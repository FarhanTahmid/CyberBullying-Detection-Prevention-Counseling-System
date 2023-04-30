import 'package:flutter/material.dart';
import '../Complain/complain.dart';
import 'package:velocity_x/velocity_x.dart';

class ComplainDetails extends StatelessWidget {
  final List complain;

  const ComplainDetails({Key? key, required this.complain})
      : assert(complain != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final approvedPic =
        "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.dreamstime.com%2Fstock-photos-reject-vs-approve-man-voting-touch-screen-response-words-voter-pressing-button-approval-proposal-image34691063&psig=AOvVaw1VpcuQYVgr_U61kvPNNKf1&ust=1682891998797000&source=images&cd=vfe&ved=0CBEQjRxqFwoTCNjRlbCL0P4CFQAAAAAdAAAAABAE";
    return Scaffold(
      body: Column(
        children: [Image.network(approvedPic)],
      ),
    );
  }
}
