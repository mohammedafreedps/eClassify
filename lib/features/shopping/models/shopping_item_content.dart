import 'package:eClassify/features/shopping/models/shopping_items_model.dart';
import 'package:uuid/uuid.dart';

List<ShoppingItemsModel> shoppingItemsModel = [
  ShoppingItemsModel(
    title: "Fresho Watermelon - Small, 1 pc 1.7 - 2.5 kg",
    mrpPrize: 109.59,
    discountPrize: 59,
    offerPercentage: 46,
    images: [
      'https://www.bigbasket.com/media/uploads/p/l/10000207_24-fresho-watermelon-small.jpg',
      'https://www.bigbasket.com/media/uploads/p/l/10000207-2_11-fresho-watermelon-small.jpg',
      'https://www.bigbasket.com/media/uploads/p/l/10000207-4_2-fresho-watermelon-small.jpg',
    ],
    packSizes: [
      PackSize(
        pieces: "1 pc",
        weight: "1.7 - 2.5 kg",
        mrpPrize: 109.59,
        discountPrize: 59,
        offerPercentage: 46,
      ),
    ],
    id: const Uuid().v1(),
    aboutProduct:
        "With greenish black to smooth dark green surface, Fresho watermelons are globular in shape and are freshly picked for you directly from our farmersThe juicy, sweet and grainy textured flesh is filled with 12-14% of sugar content, making it a healthy alternative to sugary carbonated drinks. Flesh colour of these watermelons are pink to red with dark brown/black seeds.",
    benefits:
        "Watermelons have excellent hydrating properties with 90% water content.Rich in anti-oxidant flavonoids that protects against prostate, breast, colon, pancreatic and lung cancers.",
    otherProductInfo: "EAN Code: 10000207 Country of origin: India",
  ),
  ShoppingItemsModel(
    title: "Fresho Banana - Yelakki, 500 g",
    mrpPrize: 38.36,
    discountPrize: 23,
    offerPercentage: 40,
    images: [
      'https://www.bigbasket.com/media/uploads/p/l/10000025_27-fresho-banana-robusta.jpg',
      'https://www.bigbasket.com/media/uploads/p/l/10000025-2_4-fresho-banana-robusta.jpg',
      'https://www.bigbasket.com/media/uploads/p/l/10000025-3_3-fresho-banana-robusta.jpg',
    ],
    id: const Uuid().v1(),
    packSizes: [
      PackSize(
        pieces: "500 g",
        weight: "",
        mrpPrize: 38.97,
        discountPrize: 23,
        offerPercentage: 40,
      ),
      PackSize(
        pieces: "1 kg",
        weight: "",
        mrpPrize: 120.97,
        discountPrize: 80,
        offerPercentage: 54,
      ),
      PackSize(
        pieces: "5 kg",
        weight: "",
        mrpPrize: 600.97,
        discountPrize: 400,
        offerPercentage: 32,
      ),
    ],
    aboutProduct:
        "Fresh, tiny small sized, directly procured from the farm, this variety is called Yelakki in Bangalore and Elaichi in Mumbai. Despite its small size, they are naturally flavoured, aromatic and sweeter compared to regular bananas. Yelakki bananas are around 3- 4 inches long, and contain a thinner skin and better shelf life than Robusta bananas.",
    benefits:
        "One banana supplies 30 percent of the daily vitamin B6 requirement and is rich in vitamin C, potassium and fiber. It reduces appetite and promotes weight loss, while also boosting the immune system and keeping the bones strong.",
    otherProductInfo: "EAN Code: 10000033 Country of origin: India",
  ),
  ShoppingItemsModel(
    title: "Fresho Mango- Organic, 6 pcs",
    mrpPrize: 449,
    discountPrize: 327.77,
    offerPercentage: 27,
    images: [
      'https://www.bigbasket.com/media/uploads/p/l/70000494_3-fresho-safeda-mango.jpg',
      'https://www.bigbasket.com/media/uploads/p/l/70000494-2_1-fresho-safeda-mango.jpg',
    ],
    id: const Uuid().v1(),
    packSizes: [],
    aboutProduct:
        "Fresho Organic products are organically grown and handpicked by expert. Fresho Mangoes are juicy, delicious and mouth-watering. These are also known as the King of Mangoes due to its premium quality in terms of sweetness, richness and flavour. It is famous for its unique fragrance. Product image shown is for representation purpose only, the actually product may vary based on season, produce & availability. ",
    benefits:
        "Mangoes are known as the King of Fruits because they are loaded with phytochemicals, polyphenols, vitamins, carotenoids, antioxidants, omega-3 and 6.",
    otherProductInfo: "EAN Code: 50000449 Country of origin: India",
  ),
  ShoppingItemsModel(
    title: "Fresho Apple - Royal Gala, Regular",
    mrpPrize: 597.26,
    discountPrize: 436,
    offerPercentage: 27,
    images: [
      'https://www.bigbasket.com/media/uploads/p/l/40033823-2_1-fresho-apple-royal-gala-regular.jpg',
      'https://www.bigbasket.com/media/uploads/p/l/40033823_20-fresho-apple-royal-gala-regular.jpg',
    ],
    id: const Uuid().v1(),
    packSizes: [
      PackSize(
        pieces: "2x4 pcs",
        weight: "Multipack",
        mrpPrize: 597.26,
        discountPrize: 436,
        offerPercentage: 27,
      ),
      PackSize(
        pieces: "4 pcs",
        weight: "Multipack",
        mrpPrize: 298.63,
        discountPrize: 218,
        offerPercentage: 27,
      ),
    ],
    aboutProduct:
        "A combination of slightly tart-tasting skin and honey floral-tasting flesh, the Royal Gala apples, as the name suggests looks regal with beautiful golden-coloured streaks. Royal Gala apples are a good source of fibre and vitamin C, and they are a healthy snack or addition to a meal.",
    benefits:
        "Royal Gala apples are low in calories and high in fibre, which can help you feel full and satisfied after eating. Royal Gala apples contain polyphenols, which are antioxidants that can help reduce the risk of heart disease. Royal Gala apples contain fibre, which is prebiotic that can help",
    otherProductInfo:
        "EAN Code: 40033823 Manufactured Name & Marketed By Supermarket Grocery Supplies Pvt. Ltd The Fairway Business Park, Challaghatta Village, Behind Dell, Next to",
  ),
];

List<ShoppingItemsModel> nonVegItemsModel = [
  ShoppingItemsModel(
    id: const Uuid().v1(),
    title: "Chiken",
    mrpPrize: 220,
    discountPrize: 200,
    offerPercentage: 10,
    images: [
      'https://5.imimg.com/data5/ANDROID/Default/2020/9/WY/EM/HA/113436345/product-jpeg-500x500.jpeg',
      'https://t3.ftcdn.net/jpg/00/59/96/42/360_F_59964273_OA0iJYtGiHlHrXJuddeYaxTSguZoqXY4.jpg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSaZxVZL5mIPueyEVuO6xvNUxg6RTrWRfY0rGJ_SO8Rkw&s',
    ],
    packSizes: [],
    aboutProduct:
        "A combination of slightly tart-tasting skin and honey floral-tasting flesh, the Royal Gala apples, as the name suggests looks regal with beautiful golden-coloured streaks. Royal Gala apples are a good source of fibre and vitamin C, and they are a healthy snack or addition to a meal.",
    benefits:
        "Royal Gala apples are low in calories and high in fibre, which can help you feel full and satisfied after eating. Royal Gala apples contain polyphenols, which are antioxidants that can help reduce the risk of heart disease. Royal Gala apples contain fibre, which is prebiotic that can help",
    otherProductInfo:
        "EAN Code: 40033823 Manufactured Name & Marketed By Supermarket Grocery Supplies Pvt. Ltd The Fairway Business Park, Challaghatta Village, Behind Dell, Next to",
  ),
  ShoppingItemsModel(
    id: const Uuid().v1(),
    title: "Mutton",
    mrpPrize: 250,
    discountPrize: 210,
    offerPercentage: 15,
    images: [
      'https://thekitchencommunity.org/wp-content/uploads/2022/10/mutton-meat.jpeg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTl7s-41MVMCtyRBHOUG3BrJzhmjknX3xv6YDm7xu-4pA&s',
    ],
    packSizes: [],
    aboutProduct:
        "A combination of slightly tart-tasting skin and honey floral-tasting flesh, the Royal Gala apples, as the name suggests looks regal with beautiful golden-coloured streaks. Royal Gala apples are a good source of fibre and vitamin C, and they are a healthy snack or addition to a meal.",
    benefits:
        "Royal Gala apples are low in calories and high in fibre, which can help you feel full and satisfied after eating. Royal Gala apples contain polyphenols, which are antioxidants that can help reduce the risk of heart disease. Royal Gala apples contain fibre, which is prebiotic that can help",
    otherProductInfo:
        "EAN Code: 40033823 Manufactured Name & Marketed By Supermarket Grocery Supplies Pvt. Ltd The Fairway Business Park, Challaghatta Village, Behind Dell, Next to",
  ),
];

List<ShoppingItemsModel> winesItemsModel = [
  ShoppingItemsModel(
    id: const Uuid().v1(),
    title: "Chandon Brut NV",
    mrpPrize: 900,
    discountPrize: 750,
    offerPercentage: 10,
    images: [
      'https://thewinecellar.in/wp-content/uploads/2021/05/INW1-Chandon-Brut-NV-1.jpg',
      'https://d3lhatfimi1ec.cloudfront.net/1E62B4AA-5FF5-4E1E-9CF2-21F6F144B9E4/Products/Medium/A_A_D02542%20Daily%20Dose%20Red%20Wine%202016%20750ml%20FR%20KTK%20revd.jpg?V=11052024113817',
    ],
    packSizes: [],
    aboutProduct:
        "Pale straw yellow to a golden hue with fine persistent bubbles. Bright and fresh marked with apple, pear and citric profiles with subtle notes of bread and brioche. Creamy texture balanced with a zesty acidity. Precise with a soft dry finish.",
    benefits: "",
    otherProductInfo: "",
  ),
  ShoppingItemsModel(
    id: const Uuid().v1(),
    title: "Chandon Brut Rose NV",
    mrpPrize: 950,
    discountPrize: 800,
    offerPercentage: 10,
    images: [
      'https://thewinecellar.in/wp-content/uploads/2021/05/INW2-Chandon-Brut-NV-Rose-1.jpg',
      'https://d3lhatfimi1ec.cloudfront.net/1E62B4AA-5FF5-4E1E-9CF2-21F6F144B9E4/Products/Medium/A_A_D02542%20Daily%20Dose%20Red%20Wine%202016%20750ml%20FR%20KTK%20revd.jpg?V=11052024113817',
    ],
    packSizes: [],
    aboutProduct:
        "An elegant, fresh salmon pink colour with fine persistent bubbles. Fresh with red fruit. More prominent cherry aromas along with strawberry and black current notes. PALATE – Fresh creamy texture with a well defined fruitiness and structure from Shiraz grapes.",
    benefits: "",
    otherProductInfo: "",
  ),
];
