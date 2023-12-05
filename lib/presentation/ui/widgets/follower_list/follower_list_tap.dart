import 'package:flutter/material.dart';
import 'package:share_flare/presentation/ui/widgets/round_divider.dart';



class FollowerListTap extends StatefulWidget {
  const FollowerListTap({super.key});

  @override
  State<FollowerListTap> createState() => _FollowerListTapState();
}

class _FollowerListTapState extends State<FollowerListTap> {
  UserData user = UserData(isFollowedByMe: false);


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 19,
                backgroundColor: Color(0xFFFFEB3B),
              ),

              const SizedBox(
                width: 10,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Md Shagor",
                    style: TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w600),),
                  SizedBox(
                    height: 0,
                  ),
                  Text(
                    "@shagor06",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),

                ],
              ),
              const SizedBox(
                width: 110,
              ),
              Expanded(
                child:
                GestureDetector(
                    onTap: (){
                      setState((){
                        user.isFollowedByMe= ! user.isFollowedByMe;
                      });
                    },
                    child: AnimatedContainer (duration: Duration(microseconds:  300), height: 34,
                      decoration: BoxDecoration(
                          color:  user.isFollowedByMe? Colors.grey[200] : Colors.blue,

                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: user.isFollowedByMe? Colors.white24 : Colors.transparent,)
                      ),
                      child: Center(
                        child: Text(user.isFollowedByMe? 'Unfollow' : 'Follow', style: TextStyle(color: user.isFollowedByMe? Colors.black: Colors.white,fontWeight: FontWeight.w500),),
                      ),
                    )

                ),
              ),

            ],

          ),
        ),
        Divider(
          thickness: 1,
          color: Colors.grey[200],
        ),
      ],
    );
  }
}

class UserData {
  bool isFollowedByMe;

  UserData({required this.isFollowedByMe});
}
