Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACF073CED
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jul 2019 22:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388577AbfGXUNK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 24 Jul 2019 16:13:10 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:28908 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391912AbfGXUNF (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:13:05 -0400
Received: from [IPv6:2a01:e34:ec0c:ae81:259a:5cf4:cd92:2659] (unknown [IPv6:2a01:e34:ec0c:ae80:259a:5cf4:cd92:2659])
        by smtp3-g21.free.fr (Postfix) with ESMTPS id 8F39713F87E
        for <netfilter-devel@vger.kernel.org>; Wed, 24 Jul 2019 22:13:02 +0200 (CEST)
Subject: [PATCH iptables]: restore legacy behaviour of iptables-restore when
 rules start with -4/-6
From:   Adel Belhouane <bugs.a.b@free.fr>
To:     netfilter-devel@vger.kernel.org
Message-ID: <f056f1bb-2a73-5042-740c-f2a16958deb0@free.fr>
Date:   Wed, 24 Jul 2019 22:13:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 7bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Legacy implementation of iptables-restore / ip6tables-restore allowed
to insert a -4 or -6 option at start of a rule line to ignore it if not
matching the command's protocol. This allowed to mix specific ipv4 and ipv6
rules in a single file, as still described in iptables 1.8.3's man page in
options -4 and -6.

Example with the file /tmp/rules:

*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
-4 -A INPUT -p icmp -j ACCEPT
-6 -A INPUT -p ipv6-icmp -j ACCEPT
COMMIT

works fine with iptables-legacy-restore and ip6tables-legacy-restore but
fails for the two nft variants:

% iptables-nft-restore < /tmp/rules
% iptables-nft-save
*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
-A INPUT -p icmp -j ACCEPT
-A INPUT -p ipv6-icmp -j ACCEPT
COMMIT

The two rules were added when the -6 rule should have been ignored.

% ip6tables-nft-restore < /tmp/rules
Error occurred at line: 5
Try `ip6tables-restore -h' or 'ip6tables-restore --help' for more information.

No rule was added when the -4 rule should have been ignored and the -6
rule added.

There's a distribution bug report mentioning this problem:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=925343

The following patch restores the legacy behaviour:
- let do_parse() return and thus not add a command in those restore
special cases
- let do_commandx() ignore CMD_NONE instead of bailing out

It doesn't attempt to fix all minor anomalies, but just to fix the regression.
For example the line below should throw an error according to the man page
(and does in the legacy version), but doesn't in the nft version:

% iptables -6 -A INPUT -p tcp -j ACCEPT

Signed-off-by: Adel Belhouane <bugs.a.b@free.fr>

diff --git a/iptables/xtables.c b/iptables/xtables.c
index 93d9dcb..0e0cb5f 100644
--- a/iptables/xtables.c
+++ b/iptables/xtables.c
@@ -955,6 +955,9 @@ void do_parse(struct nft_handle *h, int argc, char *argv[],
  			break;
  
  		case '4':
+			if (p->restore && args->family == AF_INET6)
+				return;
+
  			if (args->family != AF_INET)
  				exit_tryhelp(2);
  
@@ -962,6 +965,9 @@ void do_parse(struct nft_handle *h, int argc, char *argv[],
  			break;
  
  		case '6':
+			if (p->restore && args->family == AF_INET)
+				return;
+
  			args->family = AF_INET6;
  			xtables_set_nfproto(AF_INET6);
  
@@ -1174,6 +1180,9 @@ int do_commandx(struct nft_handle *h, int argc, char *argv[], char **table,
  	case CMD_SET_POLICY:
  		ret = nft_chain_set(h, p.table, p.chain, p.policy, NULL);
  		break;
+	case CMD_NONE:
+	/* do_parse ignored the line (eg: -4 with ip6tables-restore) */
+		break;
  	default:
  		/* We should never reach this... */
  		exit_tryhelp(2);

