import 'package:crm_app/screens/tickets/tickets_render.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_styles.dart';

class Ticket {
  final String ticketId;
  final String customerName;
  final String issueDescription;
  final String priority;
  final String status;

  Ticket({
    required this.ticketId,
    required this.customerName,
    required this.issueDescription,
    required this.priority,
    required this.status,
  });
}

class ViewTickets extends StatefulWidget {
  const ViewTickets({super.key});

  @override
  State<ViewTickets> createState() => _ViewTicketsState();
}

class _ViewTicketsState extends State<ViewTickets> {
  final List<dynamic> tickets = [
    {
      "ticketId": 'T001',
      "customerName": 'Customer A',
      "issueDescription": 'Product not working',
      "priority": 'High',
      "status": 'Open',
    },
    {
      "ticketId": 'T002',
      "customerName": 'Customer B',
      "issueDescription": 'Billing inquiry',
      "priority": 'Medium',
      "status": 'In Progress',
    },
    {
      "ticketId": 'T003',
      "customerName": 'Customer C',
      "issueDescription": 'Shipping delay',
      "priority": 'High',
      "status": 'Open',
    },
    {
      "ticketId": 'T004',
      "customerName": 'Customer D',
      "issueDescription": 'Login issue',
      "priority": 'Low',
      "status": 'Resolved',
    },
    {
      "ticketId": 'T005',
      "customerName": 'Customer E',
      "issueDescription": 'Product return request',
      "priority": 'Medium',
      "status": 'In Progress',
    },
    {
      "ticketId": 'T006',
      "customerName": 'Customer F',
      "issueDescription": 'Website error',
      "priority": 'High',
      "status": 'Open',
    },
    // Add more ticket entries as needed...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: InitialStyle.background,
        body: TicketRenderer(
          data: tickets,
          title: 'Tickets',
        ));
  }
}
