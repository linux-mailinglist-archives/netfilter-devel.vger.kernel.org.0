Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F9E73B603
	for <lists+netfilter-devel@lfdr.de>; Fri, 23 Jun 2023 13:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjFWLXw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 23 Jun 2023 07:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjFWLXv (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 23 Jun 2023 07:23:51 -0400
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1323D1739;
        Fri, 23 Jun 2023 04:23:49 -0700 (PDT)
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
        by mx0.infotecs.ru (Postfix) with ESMTP id 1178A110A562;
        Fri, 23 Jun 2023 14:23:47 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 1178A110A562
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
        t=1687519427; bh=kIEjeLlwMyGE/F2FO5BfREgq/lnS99K0Zaa4Lod/2nY=;
        h=From:To:CC:Subject:Date:From;
        b=qpxoJe2b/id7wbMIsRr4KeQdxLDYmXrDXbGiC6yBrxGnm4uuRjXR4Lmpyt28kt9nZ
         mbCwcL1afIAw0A9gmsOie/Ou4K/W8EtbyEiGWbPrC4Ctoc9UhJIul4PWjWLhREMl6K
         oh49fI2zqizyqTFnATQj5e4YRJ/No4UV/jY0pg+0=
Received: from msk-exch-01.infotecs-nt (msk-exch-01.infotecs-nt [10.0.7.191])
        by mx0.infotecs-nt (Postfix) with ESMTP id 0DFC430CDD64;
        Fri, 23 Jun 2023 14:23:47 +0300 (MSK)
From:   Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
CC:     Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Patrick McHardy <kaber@trash.net>,
        "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
        "coreteam@netfilter.org" <coreteam@netfilter.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        Simon Horman <simon.horman@corigine.com>
Subject: [PATCH net] netfilter: nf_conntrack_sip: fix the
 ct_sip_parse_numerical_param() return value.
Thread-Topic: [PATCH net] netfilter: nf_conntrack_sip: fix the
 ct_sip_parse_numerical_param() return value.
Thread-Index: AQHZpcUtMQS/azgYmUuZ/5v6pmZwlQ==
Date:   Fri, 23 Jun 2023 11:23:46 +0000
Message-ID: <20230623112247.1468836-1-Ilia.Gavrilov@infotecs.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.17.0.10]
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 178208 [Jun 23 2023]
X-KLMS-AntiSpam-Version: 5.9.59.0
X-KLMS-AntiSpam-Envelope-From: Ilia.Gavrilov@infotecs.ru
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=none
X-KLMS-AntiSpam-Info: LuaCore: 517 517 b0056c19d8e10afbb16cb7aad7258dedb0179a79, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;infotecs.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2023/06/23 08:19:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2023/06/23 08:45:00 #21561595
X-KLMS-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: "Ilia.Gavrilov" <Ilia.Gavrilov@infotecs.ru>

ct_sip_parse_numerical_param() returns only 0 or 1 now.
But process_register_request() and process_register_response() imply
checking for a negative value if parsing of a numerical header parameter
failed.
The invocation in nf_nat_sip() looks correct:
 	if (ct_sip_parse_numerical_param(...) > 0 &&
 	    ...) { ... }

Make the return value of the function ct_sip_parse_numerical_param()
a tristate to fix all the cases
a) return 1 if value is found; *val is set
b) return 0 if value is not found; *val is unchanged
c) return -1 on error; *val is undefined

Found by InfoTeCS on behalf of Linux Verification Center
(linuxtesting.org) with SVACE.

Fixes: 0f32a40fc91a ("[NETFILTER]: nf_conntrack_sip: create signalling expe=
ctations")
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Ilia.Gavrilov <Ilia.Gavrilov@infotecs.ru>
---
- Fix description
- Repost according
    https://lore.kernel.org/all/20230622144325.GC29784@breakpoint.cc/
 net/netfilter/nf_conntrack_sip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_sip.c b/net/netfilter/nf_conntrack_=
sip.c
index 77f5e82d8e3f..d0eac27f6ba0 100644
--- a/net/netfilter/nf_conntrack_sip.c
+++ b/net/netfilter/nf_conntrack_sip.c
@@ -611,7 +611,7 @@ int ct_sip_parse_numerical_param(const struct nf_conn *=
ct, const char *dptr,
 	start +=3D strlen(name);
 	*val =3D simple_strtoul(start, &end, 0);
 	if (start =3D=3D end)
-		return 0;
+		return -1;
 	if (matchoff && matchlen) {
 		*matchoff =3D start - dptr;
 		*matchlen =3D end - start;
--=20
2.39.2
