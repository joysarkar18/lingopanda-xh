import 'package:flutter/material.dart';
import 'package:lingopanda_xh/constants/colors_constants.dart';
import 'package:lingopanda_xh/constants/string_constants.dart';
import 'package:lingopanda_xh/constants/text_styles_constants.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({
    super.key,
    required this.name,
    required this.comment,
    required this.email,
    required this.isEmailFull,
  });

  final String name;
  final String email;
  final String comment;
  final bool isEmailFull;

  String _maskedEmail(String email) {
    final indexOfAt = email.indexOf('@');
    if (indexOfAt > 3) {
      return '${email.substring(0, 3)}****${email.substring(indexOfAt)}';
    }
    return '****${email.substring(indexOfAt)}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      height: 152,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 46,
                width: 46,
                decoration: BoxDecoration(
                    color: AppColors.appGrey, shape: BoxShape.circle),
                child: Center(
                  child: Text(
                    name.substring(0, 1).toUpperCase(),
                    style: PoppinsTextStyle.bold(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "${StringConstants.name} : ",
                        style: PoppinsTextStyle.regular(
                            color: AppColors.appGrey, fontSize: 13),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 190,
                        child: Text(
                          name,
                          overflow: TextOverflow.ellipsis,
                          style: PoppinsTextStyle.bold(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "${StringConstants.email} : ",
                        style: PoppinsTextStyle.regular(
                          color: AppColors.appGrey,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 190,
                        child: Text(
                          isEmailFull ? email : _maskedEmail(email),
                          overflow: TextOverflow.ellipsis,
                          style: PoppinsTextStyle.bold(),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 2,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 56),
            child: Text(
              comment,
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
              style: PoppinsTextStyle.regular(fontSize: 13),
            ),
          )
        ],
      ),
    );
  }
}
