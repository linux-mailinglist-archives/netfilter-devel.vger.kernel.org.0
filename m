Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F45361DDD8
	for <lists+netfilter-devel@lfdr.de>; Sat,  5 Nov 2022 20:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiKEToy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 5 Nov 2022 15:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiKETox (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 5 Nov 2022 15:44:53 -0400
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2115.outbound.protection.outlook.com [40.107.103.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5593F1005D
        for <netfilter-devel@vger.kernel.org>; Sat,  5 Nov 2022 12:44:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alInPNl+W9Aa7HEWRlIE2LseLDEMIoZp0Ko4DXTYJYLMp3hDz8DyB7oRRP/uk8i1vtSVcM8oLe2KVymJe61euyJFHNWNYhLI6sXI9/+EVqeCb6mIPXQE/eY7eAcbMN2qHNT1SI7MgjOiZt/aC6xud4h3rJ5hX5N+voK5sMWA37jcEudImlWwM1HnopLILhlDehrLzETBz25/n1MhsRKT5sGfNozU9XHfthhx8gJqx0INnwqAorWXEEV31CvoJEVCm7JlBTP/GutTv0UFflQaUvAPWGn+Qor69EAqcRz4XQPPybl1Gt5gRC6rQyds5Skf+KFRSxWCSrfZfjH6qEGPww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SuB8XAEUYXvaX9zfkMo0Sx7A33Ma60/9EExEqI4yw4M=;
 b=XPPXxofsHbeQoN8SkeohMx9j4uOv6cGFgo7g8OS9FbDa4qKNeOvLG9/UFa1WNpUFV5E/qgX/TyHVIC6hPxYI8Jmqx7H3Mqfc7LJ5/uVUeT/dyT/M99u1/jhTor39QZkbggrEwXBAgaAUG6/Bc1BXIR1tQBNUo7FESVw3egIqmY2shpzW2p9OSROFd2caEVr+mTBebNx1ohzg73hfwWxZHaNjo/scW1UxOY6yztRD81cr9mvJXVJWat0tAKwLjd3Jv1aRwJuwaSTrESNMas0cGarzEeOVEOOIIGAzOCXbabwv5DLpUPqFx+B330NAwbKl8+N4EgCSAeLFJt3zzoALpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuB8XAEUYXvaX9zfkMo0Sx7A33Ma60/9EExEqI4yw4M=;
 b=m8P9ekFS8t+QFj5niC/7L60kpWy6KUrYhso/FjMxISHUqR5aMT6xwdd4++lrZN5wswpl7jusvojgouHWKsmpP6RMdGvTjNNH5eTx5W2NxHQc3jenBd8T9q0rM0R74hZOSd/jucK65if4z7v1h/CPGOG7jS4pxwCI+kuIaP7u8U0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by DB3P189MB2332.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:432::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.9; Sat, 5 Nov
 2022 19:44:47 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::9a8b:297a:91d9:67c8]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::9a8b:297a:91d9:67c8%8]) with mapi id 15.20.5813.011; Sat, 5 Nov 2022
 19:44:46 +0000
From:   Sriram Yagnaraman <sriram.yagnaraman@est.tech>
To:     netfilter-devel@vger.kernel.org
Cc:     Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
        Florian Westphal <fw@strlen.de>, claudio.porfiri@ericsson.com
Subject: [PATCH v3] netfilter: conntrack: add sctp DATA_SENT state
Date:   Fri,  4 Nov 2022 18:18:35 +0100
Message-Id: <20221104171835.1224-1-sriram.yagnaraman@est.tech>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0053.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::21) To DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:1e7::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP189MB1433:EE_|DB3P189MB2332:EE_
X-MS-Office365-Filtering-Correlation-Id: 93f85856-d515-47ae-8706-08dabf6631a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qik60+qWWtcYHBggAmdzZHc3teXnYMyV1I/dhBTgfHyqgj7wJe7jq2O6l6H/gFsu5NhVbWIy1KAj8bTy6IofvRnxgxav5AAQa99bVu5G2TrI2ATu1HfPYcIDfdHCTwjWPPgwtGxuiWRi7bckrRVX4Gv48LC9SsoikzESnUEJjxhXVipQmYRrIwIEY68MXej5I+sVP5MsTmosunG4l/azR7Vdz7sT1v0apz6/OS9LkuhlVoyZBI5wfSVjRU6JlwTqa9f2mRhPB665+m3I5yrdJtMugEpiJ3Qy41n/pCG/3dKoc+kanCYWdpZr5AFuv03ykfsD6TTpIUHcgKXUYPmgrpWnjHPZOnT3WOTNNJbcpyE2fMAYeMAdHqUDuva1YiYOJWSGMHmlLI1A5zxYiBxzI2WMnaQUUy2ybBIq+iUHYVKleoi1Y/OqEAdOBWDmb/Vhsl7xW6kfyF0rdc+KCc9QFzIOMmfrX2k2IIJ/wUl8VIXJogm7LTAC94CsM46FKy67qqu9hxfdTMMCXCgbQwDY+n8AjOijQ4DADV7AHQlcWxXuc37OQvxjsoa6V6rldDeboDpZvIwg9wtuk/4w+/ay8bcltYuq5Dejlt3d0ieH/WmRQgeOwsNeCOVLWToqYIgoFIqmghBf58ctd0VZILjx89KCOcQvI7PZPV/Wu4rBSxj77iLCsK1LV1P/W8NERZtgijbHJVLhbYJ6zmmSMEmEfbJSGdHwB7i3MWS8XatJ9QZPLVsKnrnjHFDNCk86l8PL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(39830400003)(136003)(346002)(451199015)(186003)(1076003)(30864003)(2616005)(44832011)(5660300002)(83380400001)(41300700001)(8936002)(2906002)(86362001)(36756003)(38100700002)(6666004)(54906003)(316002)(6916009)(66476007)(66556008)(70586007)(8676002)(6486002)(66946007)(478600001)(6512007)(26005)(6506007)(4326008)(37730700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1HFPgW+HqpVBVf4Ue3kO71GivJsNGnPQLJY+a8znM4AIbnb5nbmO0zHg4vL8?=
 =?us-ascii?Q?1J8qcdw8a13T1lLiwTY1QKB3brGy0t0qqybMlipeiQ6R7ssY7RqwrryZPglO?=
 =?us-ascii?Q?IGNDHtGjjW/1vMgAng6U/1H6nXmqaRTnmFmQwXCly5JNcKib7UY+qJnMl6lz?=
 =?us-ascii?Q?M4ki/0BNFqxUWRN16lX6wYMZ1VSv8H7NlAGCS6Ls0uXaXNZJy4lasTMRNIXg?=
 =?us-ascii?Q?cyPErK2jlpvbJEG3TYjoN2ut/Ii+ewgB/THLPTdGVnjgJb3213Rj8H4TCA4w?=
 =?us-ascii?Q?QQoaJb95O0StjPOkW4/tGstT/K9CDiDfWLb+ahDqZYKXX48pSKqedPnUjT0N?=
 =?us-ascii?Q?v74x06qISmcKpDq7J+H3+fEFEToqWiLZ4+06uU59blXbiusuWXz+V5ns+1cu?=
 =?us-ascii?Q?O8UGeJoDJtdTDtsKg4quDfD9WLYJ02EonztHeRpOOGLfsIkRzc1SgVpgPFsg?=
 =?us-ascii?Q?SxCKtGucV+60JCNic5GF/NeYohhPLZ/2csRNVuBXqoijQ+1lKnv4hHCGU7f+?=
 =?us-ascii?Q?5ppBEk6KIg+hxYTuHLUQiZUXmC7Ee4BAQrrcRgIdSThHyti0z4MOMMn2SiNO?=
 =?us-ascii?Q?wl8Ii9rRu6VwmeOgWsAR+U8Baf+bFZC4MCsK4WVbrlBoaVYPlyQFjDDYlsaB?=
 =?us-ascii?Q?qOtD2jCzLhDZwmkNyz16Wxfr7q/biw6rydyxSvOua55eONbhJPgcSgIxKhEr?=
 =?us-ascii?Q?K9/xaG41zFoLFixsPvIr4CTlaNaVfbgsbUni30Dj36TPdaeZEk2OVl+n6Hhb?=
 =?us-ascii?Q?nwn0hpkuQFodbia+syarUBCU3tKQbfP46DM1MnYiu7Kvphpf6UB1HS21BPoX?=
 =?us-ascii?Q?eN9X8iHnWAljrHgT75opgv9zGsrnVfOerAm5CXYHABUnMTkK2ls5/UTk9vVy?=
 =?us-ascii?Q?6Msuvi5xcUhXpYwKVxe9mGv3ZVoUBeNMJA4g0TzGW0ZJBOshISpL3gXlVUSv?=
 =?us-ascii?Q?6V+Io/+Ws1IFy97WJ9qbAtnneaFQl09V6h0Rffz6xGSU/+c/tqhExE7AzGcN?=
 =?us-ascii?Q?7L0+Ng65N6Mbnpbiw84/ceTYMi086BJLHuZJAl41LPo/w4noRK8Lf4FLMBao?=
 =?us-ascii?Q?yM/aQOKHwLanbsYswnouaAQxd7exoZ6SPupd8+jd4dOpVGldqFbux75GGxcj?=
 =?us-ascii?Q?MAFfj0/ooYmvu5QaQYB82Eb2l3NCoC6Z0lD/p9dWimD/DXRP9czMzfKxFLUu?=
 =?us-ascii?Q?oMrchPJmp2uHeW047yuk3pTwhZjTi0z3Q+tjLeijb0sBNFyvwb09xYb1IlYv?=
 =?us-ascii?Q?u3cRz8/aGfybK+lqH+kLKqKTOQ5N3JEVII/7WwjKvYiKmYuwr2gUsf856bKZ?=
 =?us-ascii?Q?f38hPYnbJg43g9dGkwUpZcRjj2zxTtTU3LFdynFkW+tv9WA4nleQ6+QUptRc?=
 =?us-ascii?Q?2Ep62W34mjROT7WnFgl6z6vKqFUyF4nSlOjZnFyFNfhaZQNUDo6mvJpqkkWR?=
 =?us-ascii?Q?EAWJ2pJFwYxftHPi/tmhNR0W7zExaln6FMpuElPk+IB4RUdHxZl1ENeICZm3?=
 =?us-ascii?Q?OhpS80ScmWh8QAEb7BlCuBX0vL28VGTK5wnbB65v0Y5WzO1q4kleAfNMV7tt?=
 =?us-ascii?Q?/dlED9qetakyMICGMZB2kUo0p8SMaGa1QWDsHDGGN4ldtcyfQ1nUsjWMtmzu?=
 =?us-ascii?Q?NQ=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f85856-d515-47ae-8706-08dabf6631a1
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2022 19:44:46.7835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 34J0XWsRzVA7h1YzncyLTgctUs9K3zoXmqN+shxjWTBllYSvW9t0BfJsB03lYuFLx2wJ3gEQHc8AMZ7k+7yVEdf4uMWG48KgVMUbcT1fMw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3P189MB2332
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Changes since v2:
- Abandoned the sctp no_random_port patch from the series

SCTP conntrack currently assumes that the SCTP endpoints will
probe secondary paths using HEARTBEAT before sending traffic.

But, according to RFC 9260, SCTP endpoints can send any traffic
on any of the confirmed paths after SCTP association is up.
SCTP endpoints that sends INIT will confirm all peer addresses
that upper layer configures, and the SCTP endpoint that receives
COOKIE_ECHO will only confirm the address it sent the INIT_ACK to.

So, we can have a situation where the INIT sender can start to
use secondary paths without the need to send HEARTBEAT. This patch
allows DATA/SACK packets to create new connection tracking entry.

A new state has been added to indicate that a DATA/SACK chunk has
been seen in the original direction - SCTP_CONNTRACK_DATA_SENT.
State transitions mostly follows the HEARTBEAT_SENT, except on
receiving HEARTBEAT/HEARTBEAT_ACK/DATA/SACK in the reply direction.

State transitions in original direction:
- DATA_SENT behaves similar to HEARTBEAT_SENT for all chunks,
   except that it remains in DATA_SENT on receving HEARTBEAT,
   HEARTBEAT_ACK/DATA/SACK chunks
State transitions in reply direction:
- DATA_SENT behaves similar to HEARTBEAT_SENT for all chunks,
   except that it moves to HEARTBEAT_ACKED on receiving
   HEARTBEAT/HEARTBEAT_ACK/DATA/SACK chunks

Note: This patch still doesn't solve the problem when the SCTP
endpoint decides to use primary paths for association establishment
but uses a secondary path for association shutdown. We still have
to depend on timeout for connections to expire in such a case.

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
---
 .../uapi/linux/netfilter/nf_conntrack_sctp.h  |   1 +
 .../linux/netfilter/nfnetlink_cttimeout.h     |   1 +
 net/netfilter/nf_conntrack_proto_sctp.c       | 104 ++++++++++--------
 net/netfilter/nf_conntrack_standalone.c       |   8 ++
 4 files changed, 71 insertions(+), 43 deletions(-)

diff --git a/include/uapi/linux/netfilter/nf_conntrack_sctp.h b/include/uapi/linux/netfilter/nf_conntrack_sctp.h
index edc6ddab0de6..c742469afe21 100644
--- a/include/uapi/linux/netfilter/nf_conntrack_sctp.h
+++ b/include/uapi/linux/netfilter/nf_conntrack_sctp.h
@@ -16,6 +16,7 @@ enum sctp_conntrack {
 	SCTP_CONNTRACK_SHUTDOWN_ACK_SENT,
 	SCTP_CONNTRACK_HEARTBEAT_SENT,
 	SCTP_CONNTRACK_HEARTBEAT_ACKED,
+	SCTP_CONNTRACK_DATA_SENT,
 	SCTP_CONNTRACK_MAX
 };
 
diff --git a/include/uapi/linux/netfilter/nfnetlink_cttimeout.h b/include/uapi/linux/netfilter/nfnetlink_cttimeout.h
index 6b20fb22717b..94e74034706d 100644
--- a/include/uapi/linux/netfilter/nfnetlink_cttimeout.h
+++ b/include/uapi/linux/netfilter/nfnetlink_cttimeout.h
@@ -95,6 +95,7 @@ enum ctattr_timeout_sctp {
 	CTA_TIMEOUT_SCTP_SHUTDOWN_ACK_SENT,
 	CTA_TIMEOUT_SCTP_HEARTBEAT_SENT,
 	CTA_TIMEOUT_SCTP_HEARTBEAT_ACKED,
+	CTA_TIMEOUT_SCTP_DATA_SENT,
 	__CTA_TIMEOUT_SCTP_MAX
 };
 #define CTA_TIMEOUT_SCTP_MAX (__CTA_TIMEOUT_SCTP_MAX - 1)
diff --git a/net/netfilter/nf_conntrack_proto_sctp.c b/net/netfilter/nf_conntrack_proto_sctp.c
index 5a936334b517..fb1d883f2bf9 100644
--- a/net/netfilter/nf_conntrack_proto_sctp.c
+++ b/net/netfilter/nf_conntrack_proto_sctp.c
@@ -60,6 +60,7 @@ static const unsigned int sctp_timeouts[SCTP_CONNTRACK_MAX] = {
 	[SCTP_CONNTRACK_SHUTDOWN_ACK_SENT]	= 3 SECS,
 	[SCTP_CONNTRACK_HEARTBEAT_SENT]		= 30 SECS,
 	[SCTP_CONNTRACK_HEARTBEAT_ACKED]	= 210 SECS,
+	[SCTP_CONNTRACK_DATA_SENT]		= 30 SECS,
 };
 
 #define	SCTP_FLAG_HEARTBEAT_VTAG_FAILED	1
@@ -74,6 +75,7 @@ static const unsigned int sctp_timeouts[SCTP_CONNTRACK_MAX] = {
 #define	sSA SCTP_CONNTRACK_SHUTDOWN_ACK_SENT
 #define	sHS SCTP_CONNTRACK_HEARTBEAT_SENT
 #define	sHA SCTP_CONNTRACK_HEARTBEAT_ACKED
+#define	sDS SCTP_CONNTRACK_DATA_SENT
 #define	sIV SCTP_CONNTRACK_MAX
 
 /*
@@ -90,15 +92,16 @@ COOKIE WAIT       - We have seen an INIT chunk in the original direction, or als
 COOKIE ECHOED     - We have seen a COOKIE_ECHO chunk in the original direction.
 ESTABLISHED       - We have seen a COOKIE_ACK in the reply direction.
 SHUTDOWN_SENT     - We have seen a SHUTDOWN chunk in the original direction.
-SHUTDOWN_RECD     - We have seen a SHUTDOWN chunk in the reply directoin.
+SHUTDOWN_RECD     - We have seen a SHUTDOWN chunk in the reply direction.
 SHUTDOWN_ACK_SENT - We have seen a SHUTDOWN_ACK chunk in the direction opposite
 		    to that of the SHUTDOWN chunk.
 CLOSED            - We have seen a SHUTDOWN_COMPLETE chunk in the direction of
 		    the SHUTDOWN chunk. Connection is closed.
 HEARTBEAT_SENT    - We have seen a HEARTBEAT in a new flow.
-HEARTBEAT_ACKED   - We have seen a HEARTBEAT-ACK in the direction opposite to
-		    that of the HEARTBEAT chunk. Secondary connection is
-		    established.
+HEARTBEAT_ACKED   - We have seen a HEARTBEAT-ACK/DATA/SACK in the direction
+		    opposite to that of the HEARTBEAT/DATA chunk. Secondary connection
+		 is established.
+DATA_SENT         - We have seen a DATA/SACK in a new flow.
 */
 
 /* TODO
@@ -112,36 +115,38 @@ cookie echoed to closed.
 */
 
 /* SCTP conntrack state transitions */
-static const u8 sctp_conntracks[2][11][SCTP_CONNTRACK_MAX] = {
+static const u8 sctp_conntracks[2][12][SCTP_CONNTRACK_MAX] = {
 	{
 /*	ORIGINAL	*/
-/*                  sNO, sCL, sCW, sCE, sES, sSS, sSR, sSA, sHS, sHA */
-/* init         */ {sCL, sCL, sCW, sCE, sES, sSS, sSR, sSA, sCW, sHA},
-/* init_ack     */ {sCL, sCL, sCW, sCE, sES, sSS, sSR, sSA, sCL, sHA},
-/* abort        */ {sCL, sCL, sCL, sCL, sCL, sCL, sCL, sCL, sCL, sCL},
-/* shutdown     */ {sCL, sCL, sCW, sCE, sSS, sSS, sSR, sSA, sCL, sSS},
-/* shutdown_ack */ {sSA, sCL, sCW, sCE, sES, sSA, sSA, sSA, sSA, sHA},
-/* error        */ {sCL, sCL, sCW, sCE, sES, sSS, sSR, sSA, sCL, sHA},/* Can't have Stale cookie*/
-/* cookie_echo  */ {sCL, sCL, sCE, sCE, sES, sSS, sSR, sSA, sCL, sHA},/* 5.2.4 - Big TODO */
-/* cookie_ack   */ {sCL, sCL, sCW, sCE, sES, sSS, sSR, sSA, sCL, sHA},/* Can't come in orig dir */
-/* shutdown_comp*/ {sCL, sCL, sCW, sCE, sES, sSS, sSR, sCL, sCL, sHA},
-/* heartbeat    */ {sHS, sCL, sCW, sCE, sES, sSS, sSR, sSA, sHS, sHA},
-/* heartbeat_ack*/ {sCL, sCL, sCW, sCE, sES, sSS, sSR, sSA, sHS, sHA}
+/*                  sNO, sCL, sCW, sCE, sES, sSS, sSR, sSA, sHS, sHA, sDS */
+/* init         */ {sCL, sCL, sCW, sCE, sES, sSS, sSR, sSA, sCW, sHA, sCW},
+/* init_ack     */ {sCL, sCL, sCW, sCE, sES, sSS, sSR, sSA, sCL, sHA, sCL},
+/* abort        */ {sCL, sCL, sCL, sCL, sCL, sCL, sCL, sCL, sCL, sCL, sCL},
+/* shutdown     */ {sCL, sCL, sCW, sCE, sSS, sSS, sSR, sSA, sCL, sSS, sCL},
+/* shutdown_ack */ {sSA, sCL, sCW, sCE, sES, sSA, sSA, sSA, sSA, sHA, sSA},
+/* error        */ {sCL, sCL, sCW, sCE, sES, sSS, sSR, sSA, sCL, sHA, sCL},/* Can't have Stale cookie*/
+/* cookie_echo  */ {sCL, sCL, sCE, sCE, sES, sSS, sSR, sSA, sCL, sHA, sCL},/* 5.2.4 - Big TODO */
+/* cookie_ack   */ {sCL, sCL, sCW, sCE, sES, sSS, sSR, sSA, sCL, sHA, sCL},/* Can't come in orig dir */
+/* shutdown_comp*/ {sCL, sCL, sCW, sCE, sES, sSS, sSR, sCL, sCL, sHA, sCL},
+/* heartbeat    */ {sHS, sCL, sCW, sCE, sES, sSS, sSR, sSA, sHS, sHA, sDS},
+/* heartbeat_ack*/ {sCL, sCL, sCW, sCE, sES, sSS, sSR, sSA, sHS, sHA, sDS},
+/* data/sack    */ {sDS, sCL, sCW, sCE, sES, sSS, sSR, sSA, sHS, sHA, sDS}
 	},
 	{
 /*	REPLY	*/
-/*                  sNO, sCL, sCW, sCE, sES, sSS, sSR, sSA, sHS, sHA */
-/* init         */ {sIV, sCL, sCW, sCE, sES, sSS, sSR, sSA, sIV, sHA},/* INIT in sCL Big TODO */
-/* init_ack     */ {sIV, sCW, sCW, sCE, sES, sSS, sSR, sSA, sIV, sHA},
-/* abort        */ {sIV, sCL, sCL, sCL, sCL, sCL, sCL, sCL, sIV, sCL},
-/* shutdown     */ {sIV, sCL, sCW, sCE, sSR, sSS, sSR, sSA, sIV, sSR},
-/* shutdown_ack */ {sIV, sCL, sCW, sCE, sES, sSA, sSA, sSA, sIV, sHA},
-/* error        */ {sIV, sCL, sCW, sCL, sES, sSS, sSR, sSA, sIV, sHA},
-/* cookie_echo  */ {sIV, sCL, sCW, sCE, sES, sSS, sSR, sSA, sIV, sHA},/* Can't come in reply dir */
-/* cookie_ack   */ {sIV, sCL, sCW, sES, sES, sSS, sSR, sSA, sIV, sHA},
-/* shutdown_comp*/ {sIV, sCL, sCW, sCE, sES, sSS, sSR, sCL, sIV, sHA},
-/* heartbeat    */ {sIV, sCL, sCW, sCE, sES, sSS, sSR, sSA, sHS, sHA},
-/* heartbeat_ack*/ {sIV, sCL, sCW, sCE, sES, sSS, sSR, sSA, sHA, sHA}
+/*                  sNO, sCL, sCW, sCE, sES, sSS, sSR, sSA, sHS, sHA, sDS */
+/* init         */ {sIV, sCL, sCW, sCE, sES, sSS, sSR, sSA, sIV, sHA, sIV},/* INIT in sCL Big TODO */
+/* init_ack     */ {sIV, sCW, sCW, sCE, sES, sSS, sSR, sSA, sIV, sHA, sIV},
+/* abort        */ {sIV, sCL, sCL, sCL, sCL, sCL, sCL, sCL, sIV, sCL, sIV},
+/* shutdown     */ {sIV, sCL, sCW, sCE, sSR, sSS, sSR, sSA, sIV, sSR, sIV},
+/* shutdown_ack */ {sIV, sCL, sCW, sCE, sES, sSA, sSA, sSA, sIV, sHA, sIV},
+/* error        */ {sIV, sCL, sCW, sCL, sES, sSS, sSR, sSA, sIV, sHA, sIV},
+/* cookie_echo  */ {sIV, sCL, sCW, sCE, sES, sSS, sSR, sSA, sIV, sHA, sIV},/* Can't come in reply dir */
+/* cookie_ack   */ {sIV, sCL, sCW, sES, sES, sSS, sSR, sSA, sIV, sHA, sIV},
+/* shutdown_comp*/ {sIV, sCL, sCW, sCE, sES, sSS, sSR, sCL, sIV, sHA, sIV},
+/* heartbeat    */ {sIV, sCL, sCW, sCE, sES, sSS, sSR, sSA, sHS, sHA, sHA},
+/* heartbeat_ack*/ {sIV, sCL, sCW, sCE, sES, sSS, sSR, sSA, sHA, sHA, sHA},
+/* data/sack    */ {sIV, sCL, sCW, sCE, sES, sSS, sSR, sSA, sHA, sHA, sHA},
 	}
 };
 
@@ -253,6 +258,11 @@ static int sctp_new_state(enum ip_conntrack_dir dir,
 		pr_debug("SCTP_CID_HEARTBEAT_ACK");
 		i = 10;
 		break;
+	case SCTP_CID_DATA:
+	case SCTP_CID_SACK:
+		pr_debug("SCTP_CID_DATA/SACK");
+		i = 11;
+		break;
 	default:
 		/* Other chunks like DATA or SACK do not change the state */
 		pr_debug("Unknown chunk type, Will stay in %s\n",
@@ -306,7 +316,9 @@ sctp_new(struct nf_conn *ct, const struct sk_buff *skb,
 				 ih->init_tag);
 
 			ct->proto.sctp.vtag[IP_CT_DIR_REPLY] = ih->init_tag;
-		} else if (sch->type == SCTP_CID_HEARTBEAT) {
+		} else if (sch->type == SCTP_CID_HEARTBEAT ||
+				sch->type == SCTP_CID_DATA ||
+				sch->type == SCTP_CID_SACK) {
 			pr_debug("Setting vtag %x for secondary conntrack\n",
 				 sh->vtag);
 			ct->proto.sctp.vtag[IP_CT_DIR_ORIGINAL] = sh->vtag;
@@ -392,19 +404,19 @@ int nf_conntrack_sctp_packet(struct nf_conn *ct,
 
 		if (!sctp_new(ct, skb, sh, dataoff))
 			return -NF_ACCEPT;
-	}
-
-	/* Check the verification tag (Sec 8.5) */
-	if (!test_bit(SCTP_CID_INIT, map) &&
-	    !test_bit(SCTP_CID_SHUTDOWN_COMPLETE, map) &&
-	    !test_bit(SCTP_CID_COOKIE_ECHO, map) &&
-	    !test_bit(SCTP_CID_ABORT, map) &&
-	    !test_bit(SCTP_CID_SHUTDOWN_ACK, map) &&
-	    !test_bit(SCTP_CID_HEARTBEAT, map) &&
-	    !test_bit(SCTP_CID_HEARTBEAT_ACK, map) &&
-	    sh->vtag != ct->proto.sctp.vtag[dir]) {
-		pr_debug("Verification tag check failed\n");
-		goto out;
+	} else {
+		/* Check the verification tag (Sec 8.5) */
+		if (!test_bit(SCTP_CID_INIT, map) &&
+		    !test_bit(SCTP_CID_SHUTDOWN_COMPLETE, map) &&
+		    !test_bit(SCTP_CID_COOKIE_ECHO, map) &&
+		    !test_bit(SCTP_CID_ABORT, map) &&
+		    !test_bit(SCTP_CID_SHUTDOWN_ACK, map) &&
+		    !test_bit(SCTP_CID_HEARTBEAT, map) &&
+		    !test_bit(SCTP_CID_HEARTBEAT_ACK, map) &&
+		    sh->vtag != ct->proto.sctp.vtag[dir]) {
+			pr_debug("Verification tag check failed\n");
+			goto out;
+		}
 	}
 
 	old_state = new_state = SCTP_CONNTRACK_NONE;
@@ -464,6 +476,11 @@ int nf_conntrack_sctp_packet(struct nf_conn *ct,
 			} else if (ct->proto.sctp.flags & SCTP_FLAG_HEARTBEAT_VTAG_FAILED) {
 				ct->proto.sctp.flags &= ~SCTP_FLAG_HEARTBEAT_VTAG_FAILED;
 			}
+		} else if (sch->type == SCTP_CID_DATA || sch->type == SCTP_CID_SACK) {
+			if (ct->proto.sctp.vtag[dir] == 0) {
+				pr_debug("Setting vtag %x for dir %d\n", sh->vtag, dir);
+				ct->proto.sctp.vtag[dir] = sh->vtag;
+			}
 		}
 
 		old_state = ct->proto.sctp.state;
@@ -684,6 +701,7 @@ sctp_timeout_nla_policy[CTA_TIMEOUT_SCTP_MAX+1] = {
 	[CTA_TIMEOUT_SCTP_SHUTDOWN_ACK_SENT]	= { .type = NLA_U32 },
 	[CTA_TIMEOUT_SCTP_HEARTBEAT_SENT]	= { .type = NLA_U32 },
 	[CTA_TIMEOUT_SCTP_HEARTBEAT_ACKED]	= { .type = NLA_U32 },
+	[CTA_TIMEOUT_SCTP_DATA_SENT]		= { .type = NLA_U32 },
 };
 #endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index 4ffe84c5a82c..a884c06abf09 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -602,6 +602,7 @@ enum nf_ct_sysctl_index {
 	NF_SYSCTL_CT_PROTO_TIMEOUT_SCTP_SHUTDOWN_ACK_SENT,
 	NF_SYSCTL_CT_PROTO_TIMEOUT_SCTP_HEARTBEAT_SENT,
 	NF_SYSCTL_CT_PROTO_TIMEOUT_SCTP_HEARTBEAT_ACKED,
+	NF_SYSCTL_CT_PROTO_TIMEOUT_SCTP_DATA_SENT,
 #endif
 #ifdef CONFIG_NF_CT_PROTO_DCCP
 	NF_SYSCTL_CT_PROTO_TIMEOUT_DCCP_REQUEST,
@@ -892,6 +893,12 @@ static struct ctl_table nf_ct_sysctl_table[] = {
 		.mode           = 0644,
 		.proc_handler   = proc_dointvec_jiffies,
 	},
+	[NF_SYSCTL_CT_PROTO_TIMEOUT_SCTP_DATA_SENT] = {
+		.procname       = "nf_conntrack_sctp_timeout_data_sent",
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec_jiffies,
+	},
 #endif
 #ifdef CONFIG_NF_CT_PROTO_DCCP
 	[NF_SYSCTL_CT_PROTO_TIMEOUT_DCCP_REQUEST] = {
@@ -1036,6 +1043,7 @@ static void nf_conntrack_standalone_init_sctp_sysctl(struct net *net,
 	XASSIGN(SHUTDOWN_ACK_SENT, sn);
 	XASSIGN(HEARTBEAT_SENT, sn);
 	XASSIGN(HEARTBEAT_ACKED, sn);
+	XASSIGN(DATA_SENT, sn);
 #undef XASSIGN
 #endif
 }
-- 
2.34.1

