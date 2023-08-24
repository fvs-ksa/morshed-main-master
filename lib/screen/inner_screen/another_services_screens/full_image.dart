import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../../../bloc/another_services_cubit/another_service/cubit.dart';
import '../../../bloc/another_services_cubit/another_service/state.dart';

class FullImageScreen extends StatefulWidget {
  int index;

  FullImageScreen({super.key, required this.index});

  @override
  State<FullImageScreen> createState() => _FullImageScreenState();
}

class _FullImageScreenState extends State<FullImageScreen> {
  @override
  initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.initState();
  }

  @override
  void dispose() {
    //SystemChrome.restoreSystemUIOverlays();
    SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var prayerTime = AnotherServicesCubit.get(context);
    return BlocConsumer<AnotherServicesCubit, AnotherServicesState>(
        listener: (context, index) {},
        builder: (context, index) {
          return AspectRatio(aspectRatio: 1, child: PhotoViewGallery.builder(
            itemCount: 1,
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                  maxScale: PhotoViewComputedScale.contained,
                  minScale: PhotoViewComputedScale.contained,
                  initialScale: PhotoViewComputedScale.contained,
                  imageProvider: NetworkImage(
                  prayerTime.prayerModel.data![widget.index].imagepath ?? ''));
            },

          ),);
        });
  }
}
//Image.network(prayerTime.prayerModel.data![widget.index].imagepath??'')