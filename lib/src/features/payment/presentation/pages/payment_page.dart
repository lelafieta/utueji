import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../campaigns/domain/entities/campaign_entity.dart';

class PaymentPage extends StatefulWidget {
  final CampaignEntity campaign;

  const PaymentPage({super.key, required this.campaign});
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  double _donationAmount = 50;
  bool _donateAnonymously = false;
  List<double> donationOptions = [0, 50, 400, 600, 800, 1000, 1200];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _amountController =
      TextEditingController(text: '50');

  Future<void> initiatePayment(CampaignEntity campaign) async {
    Dio dio = Dio();
    String url = 'https://pagamento.ao/payment/initiate';

    Map<String, dynamic> parameters = {
      'identifier': 'AO001',
      'currency': 'kz',
      'amount': _amountController.text,
      'gateway_methods': ["MulticaixaExpress"],
      'details': 'Capa de telefone',
      'ipn_url':
          'https://xfojmftgwilbvgkwfroh.supabase.co/functions/v1/payment-webhook',
      'cancel_url': 'https://webhook.site/5ce58e6d-7acc-4471-8fd1-733302556ac6',
      'success_url':
          'https://xfojmftgwilbvgkwfroh.supabase.co/functions/v1/payment-webhook',
      'public_key': 'pro_kxi4nvp7mf3rji8ziamngmn9562c7jhxtuwljnndh4n26nk0572',
      'site_name': 'Minha loja',
      'site_logo':
          'https://xfojmftgwilbvgkwfroh.supabase.co/storage/v1/object/public/avatars//logo.png',
      'checkout_theme': 'light',
      'customer': {
        'first_name': campaign.user!.firstName,
        'last_name': campaign.user!.lastName,
        'email': campaign.user!.email,
        'mobile': campaign.user!.phoneNumber,
      },
      'shipping_info': {},
      'billing_info': {},
    };

    try {
      Response response = await dio.post(url, data: parameters);
      if (response.data['status'] == 'success' &&
          response.data['redirect_url'] != null) {
        String redirectUrl = response.data['redirect_url'];

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentWebView(url: redirectUrl),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Erro ao iniciar pagamento. ${response.data}')),
        );
      }
    } catch (e) {
      print('Erro: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao iniciar pagamento. $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pagamento"),
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Entrar como montante", style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Center(
              child: Text("AOA ${_donationAmount.toInt()}",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 8),
            Center(
              child: Text("Montante mais aproximado doado por doadores",
                  style: TextStyle(color: Colors.grey)),
            ),
            Slider(
              value: _donationAmount,
              min: 50,
              max: 1200,
              divisions: 23, // Adjusted to include 50 as the starting point
              label: _donationAmount.toInt().toString(),
              onChanged: (value) {
                setState(() {
                  _donationAmount = value;
                  _amountController.text = value.toInt().toString();
                });
              },
            ),
            SizedBox(height: 16),
            Text("Payment Options", style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            _buildPaymentOption(
                "Pagamento por UPI", Icons.account_balance_wallet),
            _buildPaymentOption(
                "Cartões de Débito / Crédito", Icons.credit_card),
            _buildPaymentOption(
                "Mais Opções de Pagamento", Icons.account_balance),
            Row(
              children: [
                Checkbox(
                  value: _donateAnonymously,
                  onChanged: (value) {
                    setState(() {
                      _donateAnonymously = value!;
                    });
                  },
                ),
                Text("Doar anonimamente")
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                // backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                initiatePayment(widget.campaign);
              },
              child: Text("Continuar a Doar AOA ${_donationAmount.toInt()}",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String title, IconData icon) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: AppColors.primaryColor),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Implementar lógica de seleção
        },
      ),
    );
  }
}

// Tela de WebView para pagamento
class PaymentWebView extends StatefulWidget {
  final String url;
  const PaymentWebView({required this.url});

  @override
  _PaymentWebViewState createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) async {
            if (url.startsWith(
                'https://xfojmftgwilbvgkwfroh.supabase.co/functions/v1/payment-webhook')) {
              // Faz a requisição GET para obter os detalhes do pagamento
              try {
                final dio = Dio();
                Response response = await dio.get(url);
                // Map<String, dynamic> data = response.data;
                print(response.data);
                // Fecha a WebView e retorna os dados para a tela anterior
                Navigator.pop(context, response.data);
              } catch (e) {
                print("Erro ao obter os dados do pagamento: $e");
                Navigator.pop(
                    context, {"error": "Falha ao processar pagamento"});
              }
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Finalizar Pagamento")),
      body: WebViewWidget(controller: _controller),
    );
  }
}
