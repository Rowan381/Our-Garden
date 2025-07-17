import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'terms_services_model.dart';
export 'terms_services_model.dart';

class TermsServicesWidget extends StatefulWidget {
  const TermsServicesWidget({super.key});

  static String routeName = 'Terms_Services';
  static String routePath = '/termsServices';

  @override
  State<TermsServicesWidget> createState() => _TermsServicesWidgetState();
}

class _TermsServicesWidgetState extends State<TermsServicesWidget> {
  late TermsServicesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TermsServicesModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            'Terms & Services',
            textAlign: TextAlign.center,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.ibmPlexMono(
                    fontWeight:
                        FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
                  fontSize: 27.0,
                  letterSpacing: 0.0,
                  fontWeight:
                      FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                ),
          ),
          actions: [],
          centerTitle: false,
        ),
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0.0, -1.0),
            child: Container(
              width: double.infinity,
              height: 1013399.0,
              constraints: BoxConstraints(
                maxWidth: 570.0,
              ),
              decoration: BoxDecoration(),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 10.0, 0.0),
                      child: RichText(
                        textScaler: MediaQuery.of(context).textScaler,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).primary,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                            TextSpan(
                              text:
                                  'Introduction.Welcome to the OurGardens application and any other websites (including www.OurGardensApp.com), products or services owned or operated by Plant Culture Systems Global Group Limited (“Company” or “Plant Culture Systems” or “Plant Culture Systems Incorporated” or “we” or “us” or “our”) (collectively, the “Plant Culture Systems Service”). To access the Plant Culture Systems Service, you must at all times agree to and abide by these terms of use, including any additional guidelines, and any future modifications (collectively, these “Terms”). These Terms are a legal contract between you, a user of at least 18 years of age (“you” or “User”), and Plant Culture Systems regarding your use of the Plant Culture Systems Services.\nBy accessing, installing, browsing, using or subscribing to, or registering for the Plant Culture Systems Service (including any content created, uploaded, downloaded, copied, published, and propagated during the use of the Plant Culture Systems Service), you acknowledge that you have read, understood, and agree to be bound by these Terms. If at any time you do not agree to these Terms, please terminate your use of the Plant Culture Systems Service.\nAlthough Plant Culture Systems Service is always striving to improve itself, it is not perfect. While Plant Culture Systems make reasonable efforts to ensure the information provided is accurate, Plant Culture Systems cannot ensure the accuracy, completeness and reliability of any and all information, data or content on the Service. Therefore, You agree and understand that during Your use of Plant Culture Systems Services, no content feedback can be used as any basis for any civil or commercial activities (ESPECIALLY CANNOT BE USED AS ANY BASIS FOR EATING ANY PLANTS OR PURCHASING ANY GOODS) performed by You and/or others, otherwise all risks that may arise from such activities and all responsibilities shall be borne by you, not by Plant Culture Systems.\nAuthorized Users. Your access to and use of Plant Culture Systems Service is subject to all applicable international, national, federal, state and local laws and regulations. You represent and warrant that you will not use Plant Culture Systems Service in any manner or for any purposes that are unlawful or prohibited by these Terms. The Plant Culture Systems Service is not for persons under the age of 18. If you are under 18 years of age, then please do not use Plant Culture Systems Service.\nSpecific Features and Services. When using the Plant Culture Systems Service, you may be subject to additional posted guidelines or terms and conditions applicable to specific services and features which may be posted from time to time (the “Guidelines”). All such Guidelines are hereby incorporated by reference into the Terms. In addition, your use of the Plant Culture Systems Service is governed by the Plant Culture Systems privacy policy available at [https://www.plantculturesystems.com/privacy-policy] (the “Privacy Policy”), which is hereby incorporated by reference into the Terms, and you consent to the collection, use and disclosure of any personal information provided by you to use in accordance with the Privacy Policy.\nChanges. Plant Culture Systems may revise this Terms from time to time. Although Plant Culture Systems may include a notice on the home page of Plant Culture Systems Service that the Terms has been modified, such notice may not remain in place for any extended period of time. Accordingly, you should review the Terms as posted on Plant Culture Systems Service from time to time. Using Plant Culture Systems Service after any revised Terms has been posted will constitute your acceptance of the revised Terms.\nLimited License. Subject to the terms and conditions of these Terms, Plant Culture Systems hereby grants you a limited, revocable, non-transferable, non-exclusive, non-sublicensable license to use the Plant Culture Systems Services (and all updates or upgrades provided) solely for private, non-commercial purposes in accordance with these Terms.\nOwnership; Proprietary Rights. The Plant Culture Systems Service is owned and operated by Plant Culture Systems. The content, visual interfaces, information, graphics, design, compilation, computer code, products, software, algorithms, services, and all other elements of the Plant Culture Systems Service that are provided by Plant Culture Systems (“Plant Culture Systems Materials”) are protected by United States copyright, trade dress, patent, and trademark laws, international conventions, and all other relevant intellectual property and proprietary rights, and applicable laws. For clarity, Plant Culture Systems Materials do not include any User Content (defined below) or content from third party sites, whether Plant Culture Systems Service provides a link to them or not. All Plant Culture Systems Materials contained on Plant Culture Systems Service are the copyrighted property of Plant Culture Systems or affiliated companies and/or third party licensors. All trademarks, service marks, and trade names are proprietary to Plant Culture Systems or its affiliates and/or third party licensors. Except as expressly authorized by Plant Culture Systems, you agree not to sell, license, distribute, copy, modify, publicly perform or display, transmit, publish, edit, adapt, decompile, disassemble, reverse engineer, create derivative works from, or otherwise make unauthorized use of Plant Culture Systems Materials.\nRestrictions. As a condition of your use of the Plant Culture Systems Service, you will not use Plant Culture Systems Service for any purpose that is unlawful or prohibited by these Terms. Access to Plant Culture Systems Materials and the Plant Culture Systems Service from territories where their contents are illegal is strictly prohibited. Users are responsible for complying with all local rules, laws, regulations and policies, including, without limitation, rules about intellectual property rights, the internet, technology, data, email, and/or privacy.\nAny use by User of any of Plant Culture Systems Materials other than for private use is prohibited.\nYou will not use the Plant Culture Systems Service in any manner that in our sole discretion could damage, disable, overburden, or impair it or interfere with any other party’s use of the Plant Culture Systems Service. You will not take any action that imposes an unreasonable or disproportionately large load on Plant Culture Systems’s infrastructure. You will not intentionally interfere with or damage the operation of the Plant Culture Systems Service or any user’s enjoyment of it, by any means, including uploading or otherwise disseminating viruses, worms, or other malicious code. You will not remove, circumvent, disable, damage or otherwise interfere with any security-related features of the Plant Culture Systems Service, features that prevent or restrict the use or copying of any content accessible through the Plant Culture Systems Service, or features that enforce limitations on the use of the Plant Culture Systems Service. You will not attempt to gain unauthorized access to the Plant Culture Systems Service, or any part of it, other accounts, computer systems or networks connected to the Plant Culture Systems Service, or any part of it, through hacking, password mining or any other means or interfere or attempt to interfere with the proper working of the Plant Culture Systems Service or any activities conducted on the Plant Culture Systems Service. You will not obtain or attempt to obtain any materials or information through any means not intentionally made available through the Plant Culture Systems Service. You agree neither to modify the Plant Culture Systems Service in any manner or form, nor to use modified versions of the Plant Culture Systems Service, including (without limitation) for the purpose of obtaining unauthorized access to the Plant Culture Systems Service.\nPlant Culture Systems Service may contain robot exclusion headers. You agree that you will not use any robot, spider, scraper, or other automated means to access the Plant Culture Systems Service for any purpose without our express written permission or bypass our robot exclusion headers or other measures we may use to prevent or restrict access to the Plant Culture Systems Service. You will not utilize framing techniques to enclose any trademark, logo, or other Plant Culture Systems Materials without our express written consent. You will not use any meta tags or any other “hidden text” utilizing Plant Culture Systems’s name or trademarks without our express written consent.\nYou will not deep-link to the Plant Culture Systems Service and will promptly remove any links that Plant Culture Systems finds objectionable in its sole discretion. You will not use any Plant Culture Systems logos, graphics, or trademarks as part of the link without our express written consent.\nYou will not send junk mail to other users of the Plant Culture Systems Service, including, but not limited to unsolicited advertising, promotional materials or other solicitation material, bulk mailing of commercial advertising, chain mail, informational announcements, charity requests, and petitions for signatures.\nYour Content.\nProhibited Content. You shall not use the Plant Culture Systems Service to create, upload, download, copy, publish or propagate any images, sounds, videos, data, text, information or any other materials or content (collectively, “Content”) that: (a) violates any rule, law, regulation or policy; (b) harms national interests, endangers national security or divulges national secrets; (c) incites ethnic or racial discrimination or hatred; (d) undermines the social stability; (e) contains obscenity, sexual connotation, pornography, gambling, violence, murder, or terror; (f) insults or defames others or infringes others’ lawful rights and interests; or (g) contains abusive or threatening information.\nLicense to Your Content. You hereby grant Plant Culture Systems a worldwide, non-exclusive, irrevocable, royalty-free, fully-paid, perpetual, sublicensable (through multiple tiers), fully transferable license to use, distribute, reproduce, create derivative works from, publish, translate, publicly perform and publicly display any Content that you upload or publish to the Plant Culture Systems Services (collectively, “Your Content”), in any format or medium now known or later developed for any purpose. Plant Culture Systems can use Your Content in the App and in Plant Culture Systems’s other products or services, and can transfer the license or authorization of using such information and content to its related companies and cooperation partners with no need to obtain your consent again. Plant Culture Systems reserves the right to display advertisements and sponsorships in connection with Your Content.\nPlant Culture Systems has the right to remove, at its sole discretion and without notice to you, Your Content if it infringes others’ rights and interests. Plant Culture Systems has the right to suspend or terminate access to the Plant Culture Systems Service to any user who uses the Plant Culture Systems Service in violation of copyright law or other intellectual property law. All liabilities for damage for any claim for rights raised by the said third party shall be assumed by you, not by Plant Culture Systems, and you shall compensate for all losses and damages Plant Culture Systems incurs arising therefrom, including but not limited to economic losses and business losses.\nRepresentation and Warranty. You represent, warrant and covenant that at all times: (i) the Your Content does not infringe any third party’s intellectual property, right of reputation, right of name, right of privacy, moral rights and other lawful rights and interests; (ii) you own or have the necessary licenses, rights, consents and permissions for your use of the Your Content in connection with the Plant Culture Systems Services and Plant Culture Systems’s use of the Your Content pursuant to Section 8(b).\nIdentity Authentication. Plant Culture Systems uses many techniques to identify you when you register for and/or access, browse, use or subscribe to the Plant Culture Systems Service. This verification is only an indication of increased likelihood that your identity is correct. You authorize Plant Culture Systems, directly or through third parties, to make any inquiries Plant Culture Systems considers necessary to validate your registration.\nUser Account Information. You agree that the information you provide to Plant Culture Systems upon registration and, at all other times, will be true, accurate, current, and complete. You also agree that you will ensure that this information is kept accurate and up-to-date at all times. When you register, you will be asked to provide a password. As you will be responsible for all activities that occur under your password, you should keep your password confidential. You are solely responsible for maintaining the confidentiality of your account and password and for restricting access to your computer, and you agree to accept responsibility for all activities that occur under your account or password. If you have reason to believe that your account is no longer secure (for example, in the event of a loss, theft or unauthorized disclosure or use of your account ID, password), you will immediately notify Plant Culture Systems. You will be liable for the losses incurred by Plant Culture Systems or others due to any unauthorized use of your account.\nCommunications; Notice. Under these Terms, you consent to receive communications from Plant Culture Systems electronically. We will communicate with you by email or by posting notices on the Plant Culture Systems Service. You agree that all agreements, notices, disclosures, and other communications that we provide to you electronically satisfy any legal requirement that such communications be in writing. Except as explicitly stated otherwise, legal notices shall be served on Plant Culture Systems’s national registered agent or to the email address you provide to Plant Culture Systems during the registration process. Notice shall be deemed given 24 hours after email is sent, unless the sending party is notified that the email address is invalid. Alternatively, we may give you legal notice by mail to the address provided during the registration process. In such case, notice shall be deemed given three days after the date of mailing.\nFeedback. You may, but are not required to, provide suggestions, comments, ideas, or know-how, in any form, to Plant Culture Systems related to the Plant Culture Systems Services (“Feedback”). Any Feedback shall not be considered your confidential information and may be used by Plant Culture Systems for any purpose. There shall be no obligation to provide compensation for use of Feedback.\nThird Party Sites. The Plant Culture Systems Service may include links to other websites or services solely as a convenience to users (“Linked Sites”). Plant Culture Systems does not endorse any Linked Sites or the information, material, products or services contained on Linked Sites or accessible through Linked Sites. Furthermore, Plant Culture Systems makes no express or implied warranties with regard to the information, material, products, or services that are contained on or accessible through Linked Sites. Access and use of linked sites, including the information, material, products, and services on linked sites or available through linked sites, is solely at your own risk.\nYour correspondence or business dealings with, or participation in promotions of, advertisers found on or through the Plant Culture Systems Service are solely between you and such advertiser. You agree that Plant Culture Systems will not be responsible or liable for any loss or damage of any sort incurred as the result of any such dealings or as the result of the presence of such advertisers on the Plant Culture Systems Service.\nPlant Culture Systems may make changes to or discontinue any of the content or services available on the Plant Culture Systems Service at any time, and without notice. The content or services on the Plant Culture Systems Service may be out of date, and Plant Culture Systems makes no commitment to update these materials.\nUser Content. You acknowledge and agree that: (a) Content is provided to you AS IS and that Plant Culture Systems is not responsible for examining or evaluating Content created, uploaded, publish or propagate or otherwise made available by end users through the Plant Culture Systems Services (“User Content”); (b) Plant Culture Systems does not guarantee accuracy of any such User Content or that such User Content will continue to be available; (c) by using the Plant Culture Systems Services, you may encounter User Content that you deem offensive, indecent, or objectionable and that such User Content may not be labeled as such; and (d) Plant Culture Systems has no liability to you for any such User Content.\nTermination. You agree that Plant Culture Systems, in its sole discretion and for any or no reason, may terminate any account (or any part thereof) you may have with Plant Culture Systems. In addition, Plant Culture Systems reserves the right to discontinue any aspect of the Plant Culture Systems Service at any time, including the right to discontinue the display of any licensed content, linked or embedded content, Your Content or Third Party Content, either generally or in specific cases. For the avoidance of doubt, Plant Culture Systems shall in no event be responsible for the deletion, losing of, or failure to store Your Content. You agree that any termination of your access to the Plant Culture Systems Service or any account you may have or portion thereof may be affected without prior notice, and you agree that Plant Culture Systems will not be liable to you or any third party for such termination. Any suspected fraudulent, abusive, or illegal activity that may be grounds for termination of your use of Plant Culture Systems Service may be referred to appropriate law enforcement authorities. These remedies are in addition to any other remedies Plant Culture Systems may have at law or in equity.\nDISCLAIMERS; NO WARRANTIES. WITHOUT LIMITING ANY OTHER PROVISION OF THIS SECTION AND IN ADDITION TO ALL OTHER PROVISIONS OF THIS SECTION, TO THE FULLEST EXTENT PERMITTED BY APPLICABLE LAW, Plant Culture Systems EXPRESSLY DISCLAIMS ALL WARRANTIES AND CONDITIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION ANY IMPLIED WARRANTIES OR CONDITIONS OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, NON-INFRINGEMENT OF THIRD PARTY RIGHTS, AND THOSE ARISING FROM A COURSE OF DEALING OR USAGE OF TRADE, WITH RESPECT TO Plant Culture Systems SERVICE. Plant Culture Systems MAKES NO WARRANTY THAT Plant Culture Systems SERVICE WILL MEET YOUR REQUIREMENTS, OR THAT Plant Culture Systems SERVICE WILL BE UNINTERRUPTED, TIMELY, SECURE, OR ERROR FREE. Plant Culture Systems DOES NOT MAKE ANY WARRANTY OR REPRESENTATION AS TO THE USE OR THE RESULTS THAT MAY BE OBTAINED FROM THE USE OF Plant Culture Systems SERVICE. YOU ACKNOWLEDGE THAT Plant Culture Systems SERVICE MAY BE SUBJECT TO OPERATING ERRORS OR DEFECTS INCLUDING, BUT NOT LIMITED TO LOSS OF DATA, DELAYS, NON-DELIVERIES, ERRORS, SYSTEM DOWN TIME, MISDELIVERIES, NETWORK OR SYSTEM OUTAGES, FILE CORRUPTION, OR SERVICE INTERRUPTIONS. NO SUCH EVENT SHALL CONSTITUTE A BREACH OF THIS OR ANY OTHER CONTRACT ON THE PART OF Plant Culture Systems, EVEN IF CAUSED BY THE NEGLIGENCE OR GROSS NEGLIGENCE OF Plant Culture Systems OR ANY OF ITS AFFILIATES, EMPLOYEES, AGENTS, LICENSORS OR SUBCONTRACTORS.\nCERTAIN STATE LAWS DO NOT ALLOW LIMITATIONS ON IMPLIED WARRANTIES OR THE EXCLUSION OR LIMITATION OF CERTAIN DAMAGES. IF THESE LAWS APPLY TO YOU, SOME OR ALL OF THE ABOVE DISCLAIMERS, EXCLUSIONS, OR LIMITATIONS MAY NOT APPLY TO YOU, AND YOU MIGHT HAVE ADDITIONAL RIGHTS.\nIndemnification. You agree to indemnify and hold Plant Culture Systems, and its affiliated companies, and its suppliers and partners, harmless from any claims, losses, damages, liabilities, including attorney’s fees, arising out of your use or misuse of the Plant Culture Systems Service, violation of these Terms, violation of the rights of any other person or entity, or any breach of the foregoing representations, warranties, and covenants. Plant Culture Systems reserves the right, at our own expense, to assume the exclusive defense and control of any matter for which you are required to indemnify us and you agree to cooperate with our defense of these claims.\nLIMITATION OF LIABILITY. UNDER NO CIRCUMSTANCES, INCLUDING, BUT NOT LIMITED TO, NEGLIGENCE, SHALL Plant Culture Systems OR ITS AFFILIATES, CONTRACTORS, EMPLOYEES, AGENTS, OR THIRD PARTY PARTNERS OR SUPPLIERS, BE LIABLE TO YOU FOR ANY SPECIAL, INDIRECT, INCIDENTAL, CONSEQUENTIAL, OR EXEMPLARY DAMAGES THAT RESULT FROM YOUR USE OR THE INABILITY TO USE Plant Culture Systems MATERIALS ON Plant Culture Systems SERVICE, Plant Culture Systems SERVICE ITSELF, OR ANY OTHER INTERACTIONS WITH Plant Culture Systems, EVEN IF Plant Culture Systems OR A Plant Culture Systems AUTHORIZED REPRESENTATIVE HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. APPLICABLE LAW MAY NOT ALLOW THE LIMITATION OR EXCLUSION OF LIABILITY OR INCIDENTAL OR CONSEQUENTIAL DAMAGES, SO THE ABOVE LIMITATION OR EXCLUSION MAY NOT APPLY TO YOU. IN SUCH CASES, Plant Culture Systems’S LIABILITY WILL BE LIMITED TO THE EXTENT PERMITTED BY LAW.\nIN NO EVENT SHALL Plant Culture Systems’S OR ITS AFFILIATES, CONTRACTORS, EMPLOYEES, AGENTS, OR THIRD PARTY PARTNERS OR SUPPLIERS\' TOTAL LIABILITY TO YOU FOR ALL DAMAGES, LOSSES, AND CAUSES OF ACTION ARISING OUT OF OR RELATING TO THESE TERMS OR YOUR USE OF Plant Culture Systems SERVICE (WHETHER IN CONTRACT, TORT, WARRANTY, OR OTHERWISE) EXCEED ONE HUNDRED DOLLARS.\nTHESE LIMITATIONS SHALL ALSO APPLY WITH RESPECT TO DAMAGES INCURRED BY REASON OF ANY PRODUCTS OR SERVICES SOLD OR PROVIDED TO YOU BY THIRD PARTIES OTHER THAN Plant Culture Systems AND RECEIVED BY YOU THROUGH OR ADVERTISED ON THE Plant Culture Systems SERVICE OR RECEIVED BY YOU THROUGH ANY LINKS PROVIDED ON THE Plant Culture Systems SERVICE.\nDisputes and Arbitration.\nDisputes. For all disputes arising out of or relating in any way to the Plant Culture Systems Service, you must first send a written description of your claim to Plant Culture Systems Incorporated to allow us an opportunity to resolve the dispute. You and Plant Culture Systems Incorporated each agree to negotiate your claim in good faith. If we still cannot resolve the dispute you may request arbitration if your claim or dispute cannot be resolved within 60 days. Please read this section carefully. It affects your legal rights. It provides for resolution of disputes through individual arbitration instead of court trials and class actions. Arbitration is more informal than a lawsuit in court, uses a neutral arbitrator instead of a judge or jury, and discovery is more limited. Arbitration is final and binding and subject to only very limited review by a court. This arbitration clause shall survive termination of the Terms.\nGoverning Law. By using the Plant Culture Systems Service, you agree that the statutes and laws of the United States without regard to conflicts of laws principles, will apply to all matters relating to use of the Plant Culture Systems Service. If we are unable to commence arbitration, you agree that any litigation shall be subject to the exclusive jurisdiction of the state or federal courts in Delaware, DE and shall be subject to the laws of Delaware without giving effect to any principles of conflicts of law.\nArbitration Procedures.\nAny dispute, controversy or claim arising in any way out of or in connection with the Terms (including, without limitation: (1) any contractual, pre-contractual or non-contractual rights, obligations or liabilities; and (2) any issue as to the existence, validity or termination of the Terms) shall be referred to and finally resolved by binding arbitration administered by the International Centre for Dispute Resolution (“ICDR”) in accordance with its International Arbitration Rules in force as at the date of this Agreement (the “Rules”), which Rules are deemed to be incorporated by reference into this Section 19 and as may be amended by the rest of this Section 19.\nThe arbitration tribunal (“Tribunal”) shall consist of three (3) arbitrators. The claimant shall designate one (1) arbitrator. The respondent shall designate one (1) arbitrator. The two arbitrators thus appointed shall designate the third arbitrator who shall be the presiding arbitrator. If within fourteen (14) days of a request from the other party to do so a party fails to designate an arbitrator, or if the two arbitrators fail to designate the third arbitrator within fourteen (14) days after the confirmation of appointment of the second arbitrator, the appointment shall be made, upon request of a party, by the ICDR in accordance with the Rules.\nThe seat of the arbitration shall be Delaware, Delaware, U.S.A. The language of the arbitration shall be English. This arbitration clause shall be governed by the laws of the United States, including the Federal Arbitration Act, and to the extent not inconsistent therewith, the laws of the State of Delaware (United States).\nAny award of the Tribunal shall be made in writing and shall be final and binding on the parties from the day it is made. The parties undertake to carry out the award without delay. The arbitrator or arbitrators shall be empowered to award only those damages which are permitted by the Terms, subject to any disclaimers of damages and liability limits set forth in thee Terms, but the arbitrator or arbitrators shall not have the authority to reform, modify or materially change the Terms. The award rendered by the arbitrator(s) shall include costs of the arbitration, reasonable attorneys’ fees and reasonable costs for experts and other witnesses. Judgment on the award may be entered in any court having jurisdiction. The parties hereby irrevocably waive their right to any form of appeal, review or recourse to any court or other judicial authority insofar as such waiver may be validly made. The parties waive any right to apply to any court and/or other judicial authority to determine any preliminary point of law and/or review any question of law and/or the merits, insofar as such waiver may validly be made. The parties shall not be deemed, however, to have waived any other right to challenge any award.\nThe parties agree that the arbitrator(s) shall have the authority to issue interim orders for provisional relief, including, but not limited to, orders for injunctive relief, attachment or other provisional remedy, as necessary to protect either party’s name, proprietary information, trade secrets, know-how or any other proprietary right. The parties agree that any interim order of the arbitrator(s) for any injunctive or other preliminary relief shall be enforceable in any court of competent jurisdiction. In addition, nothing in the Terms shall be deemed as preventing either party from seeking provisional relief from any court of competent jurisdiction, in order to protect that party’s name or proprietary rights. Nothing in this Section shall be construed as preventing any party from seeking conservatory or interim relief from any court of competent jurisdiction, including without limitation to protect either party’s name, proprietary information, trade secrets, know-how or any other proprietary rights.\nMiscellaneous.\nWaiver. A provision of these Terms may be waived only by a written instrument executed by the party entitled to the benefit of such provision. The failure of any party at any time to require performance of any provision of these Terms shall in no manner affect such party’s right at a later time to enforce the same. A waiver of any breach of any provision of these Terms shall not be construed as a continuing waiver of other breaches of the same or other provisions of these Terms.\nSeverability. If any provision of these Terms shall be unlawful, void, or for any reason unenforceable, then that provision shall be deemed severable from these Terms and shall not affect the validity and enforceability of any remaining provisions.\nAssignment. The Terms, and any rights and licenses granted hereunder, may not be transferred or assigned by you, but may be assigned by Plant Culture Systems without restriction.\nSurvival. Sections 6, 8(b), 10, 11, 13, 16, 17, 18, 19, and 20 will survive any termination of these Terms.\nHeadings. The heading references herein are for convenience purposes only, do not constitute a part of these Terms, and shall not be deemed to limit or affect any of the provisions hereof.\nEntire Agreement. These Terms are the entire agreement between you and Plant Culture Systems relating to the subject matter herein and shall not be modified except in writing, signed by both parties, or by a change to these Terms made by Plant Culture Systems as set forth in Section 4.\nCLAIMS. YOU AND Plant Culture Systems AGREE THAT ANY CAUSE OF ACTION ARISING OUT OF OR RELATED TO Plant Culture Systems SERVICE MUST COMMENCE WITHIN ONE (1) YEAR AFTER THE CAUSE OF ACTION ACCRUES. OTHERWISE, SUCH CAUSE OF ACTION IS PERMANENTLY BARRED.\nEnd-User Terms Required by Apple. If you have downloaded the Plant Culture Systems Services mobile application (the “App”) from the Apple, Inc. (“Apple”) App Store or if you are using the App on an iOS device, you acknowledge that you have read, understood, and agree to the following notice regarding Apple. These Terms are between you and Plant Culture Systems only, not with Apple, and Apple is not responsible for the Plant Culture Systems Service and the content thereof. Apple has no obligation whatsoever to furnish any maintenance and support services with respect to the App. In the event of any failure of the App to conform to any applicable warranty, then you may notify Apple and Apple will refund any applicable purchase price for the App to you; and that, to the maximum extent permitted by applicable law, Apple has no other warranty obligation whatsoever with respect to the App. Apple is not responsible for addressing any claims by you or any third party relating to the App or your possession and/or use of the App, including: (a) product liability claims; (b) any claim that the App fails to conform to any applicable legal or regulatory requirement; and (c) claims arising under consumer protection or similar legislation. Apple is not responsible for the investigation, defense, settlement and discharge of any third party claim that the App and/or your possession and use of the App infringe that third party’s intellectual property rights. You agree to comply with any applicable third party terms, when using the App. Apple, and Apple’s subsidiaries, are third party beneficiaries of these Terms, and upon your acceptance of these Terms, Apple will have the right (and will be deemed to have accepted the right) to enforce these Terms against you as a third party beneficiary of these Terms.\nQueries. You may contact us at the address below with any questions, complaints or claims regarding the Plant Culture Systems Services:\nPlant Culture Systems Incorporated\n7661 Irvine Boulevard, Irvine CA, 92618, United States\nEmail: Society@Plantculturecorp.com\nDMCA/Copyright. If you believe that anything on the Plant Culture Systems Services infringes a copyright that you own or control, you may file a notice with our designated agent:\nPlant Culture Systems Incorporated\nEmail: Society@Plantculturecorp.com\nIf you file a notice with our designated agent, it must comply with the requirements set forth at 17 U.S.C. § 512(c)(3). That means the notice must: (i) contain the physical or electronic signature of a person authorized to act on behalf of the copyright owner; (ii) identify the copyrighted work claimed to have been infringed; (iii) identify the material that is claimed to be infringing or to be the subject of infringing activity and that is to be removed, or access to which is to be disabled, and information reasonably sufficient to let us locate the material; (iv) provide your contact information, including your address, telephone number, and an email address; (v) provide a personal statement that you have a good-faith belief that the use of the material in the manner complained of is not authorized by the copyright owner, its agent, or the law; (vi) provide a statement that the information in the notification is accurate and, under penalty of perjury, that you are authorized to act on behalf of the copyright owner.\n\n',
                              style: TextStyle(),
                            )
                          ],
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        ),
                      ),
                    ),

                    // This row exists for when the "app bar" is hidden on desktop, having a way back for the user can work well.
                    if (responsiveVisibility(
                      context: context,
                      phone: false,
                      tablet: false,
                    ))
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 8.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.safePop();
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 12.0, 0.0, 12.0),
                                child: Icon(
                                  Icons.arrow_back_rounded,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  'Back',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 10.0, 0.0, 30.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            context.safePop();
                          },
                          text: 'Accept and Agree',
                          options: FFButtonOptions(
                            height: 40.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).secondary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                            elevation: 3.0,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
