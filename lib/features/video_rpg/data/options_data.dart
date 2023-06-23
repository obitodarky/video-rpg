class Choice {
  final String title;
  final String videoUrl;
  final List<Choice> nextChoices;

  Choice({
    required this.title,
    required this.videoUrl,
    required this.nextChoices,
  });
}

Choice getMockData() {

  Choice choice4 = Choice(
    title: 'Choice 4',
    videoUrl:
    'https://packaged-media.redd.it/8qdnh003oo7b1/pb/m2-res_480p.mp4?m=DASHPlaylist.mpd&v=1&e=1687510800&s=65e67c7ebc620400fad611c2547f45b5a411f6b2#t=0',
    nextChoices: [],
  );

  Choice choice3 = Choice(
    title: 'Choice 3',
    videoUrl:
    'https://packaged-media.redd.it/8qdnh003oo7b1/pb/m2-res_480p.mp4?m=DASHPlaylist.mpd&v=1&e=1687510800&s=65e67c7ebc620400fad611c2547f45b5a411f6b2#t=0',
    nextChoices: [],
  );

  Choice choice2 = Choice(
    title: 'Choice 2',
    videoUrl:
    'https://packaged-media.redd.it/607wtjxpqi7b1/pb/m2-res_480p.mp4?m=DASHPlaylist.mpd&v=1&e=1687510800&s=745b542226f9276c8186a815c32af812e9563695#t=0',
    nextChoices: [choice3, choice4],
  );

  Choice choice1 = Choice(
    title: 'Choice 1',
    videoUrl:
    'https://packaged-media.redd.it/3it2o7bzjf7b1/pb/m2-res_480p.mp4?m=DASHPlaylist.mpd&v=1&e=1687411374&s=b18d923231e3b8bd7c79fb1dd9a60879e5fb4127#t=0',
    nextChoices: [choice2, choice3],
  );

  Choice rootChoice = Choice(
    title: 'Root Choice',
    videoUrl:
    'https://packaged-media.redd.it/x4o7gig08h7b1/pb/m2-res_480p.mp4?m=DASHPlaylist.mpd&v=1&e=1687418613&s=bdc7b86f325a0adfe7a9578971d98bd7570ec0fa#t=0',
    nextChoices: [choice1, choice2],
  );

  return rootChoice;
}