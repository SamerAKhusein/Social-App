import 'package:flutter/material.dart';
import 'package:social/shared/styles/colors.dart';
import 'package:social/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget
{
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    return  SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          const Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 10.0,
            margin: EdgeInsets.all(8.0),
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Image(
                  image: NetworkImage('https://www.seiu1000.org/sites/main/files/main-images/camera_lense_0.jpeg'),
                  fit: BoxFit.cover,
                  height: 150.0,
                  width: double.infinity,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Communicate with friends',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      height: 1.3,
                    ),
                  ),
                ),
              ],

            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => buildPostItem(context),
            separatorBuilder: (context, index) => SizedBox(
              height: 8.0,
            ),
            itemCount: 10,
          ),
          SizedBox(
            height: 8.0,
          ),


        ],
      ),
    );
  }

  Widget buildPostItem(context) => Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5.0,
    margin: const EdgeInsets.all(10.0),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                  'https://www.seiu1000.org/sites/main/files/main-images/camera_lense_0.jpeg',


                ),
              ),
              const SizedBox(
                width: 15.0,
              ),
              const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Samer Akram',
                            style: TextStyle(
                              height: 1.4,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: defaultColor,
                            size: 16.0,
                          ),

                        ],
                      ),
                      Text(
                        'Jan 25 , 2023 at 11:00 pm',
                        style: TextStyle(
                          height: 1.4,
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),

                      ),
                    ],
                  )
              ),
              const SizedBox(
                width: 15.0,
              ),
              IconButton(
                icon: const Icon(
                  Icons.more_horiz,
                  size: 16.0,
                ),
                onPressed: () {},

              )

            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          const Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book',
            style: TextStyle(
              fontSize: 13.0,
              height: 1.4,
            ),

          ),
          Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 10.0,
                top: 5.0,
              ),
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      end: 5.0,
                    ),
                    child: Container(
                      height: 25.0,
                      child: MaterialButton(
                        onPressed: (){},
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        child: const Text(
                          '#software',
                          style: TextStyle(
                            color: defaultColor,

                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
          Container(
            height: 140.0,
            width: double.infinity,
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular
                (
                  4.0
              ),
              image: const DecorationImage(
                image: NetworkImage('https://www.seiu1000.org/sites/main/files/main-images/camera_lense_0.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child:  InkWell(
                    child: const Padding(
                      padding:  EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      child:  Row(
                        children: [
                          Icon(
                            IconBroken.Heart,
                            color: Colors.red,
                            size: 16.0,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '1400',
                            // style: TextStyle(
                            //   color: Colors.grey,
                            //   fontSize: 16.0,
                            //
                            // ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
                Expanded(
                  child:  InkWell(
                    child: const Padding(
                      padding:  EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconBroken.Chat,
                            color: Colors.amber,
                            size: 16.0,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '1400 comments',
                            // style: TextStyle(
                            //   color: Colors.grey,
                            //   fontSize: 16.0,
                            //
                            // ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                ),

              ],
            ),

          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Row(
            children: [
              const Expanded(
                child: InkWell(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18.0,
                        backgroundImage: NetworkImage(
                          'https://www.seiu1000.org/sites/main/files/main-images/camera_lense_0.jpeg',


                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        'write a comment ...',
                        style: TextStyle(
                          height: 1.4,
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),

                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                child:  const Row(
                  children: [
                    Icon(
                      IconBroken.Heart,
                      color: Colors.red,
                      size: 16.0,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'Like',
                    ),

                  ],
                ),
                onTap: () {},
              ),
              SizedBox(
                width: 5.0,
              ),
              InkWell(
                child: const Row(
                  children: [
                    Icon(
                      IconBroken.Send,
                      color: Colors.green,
                      size: 16.0,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      '1400',

                    ),
                  ],
                ),
                onTap: () {},
              ),
            ],
          ),



        ],
      ),
    ),
  );

}