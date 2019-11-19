Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6D84101081
	for <lists+netfilter-devel@lfdr.de>; Tue, 19 Nov 2019 02:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfKSBHa (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 18 Nov 2019 20:07:30 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41709 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726962AbfKSBHa (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 18 Nov 2019 20:07:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574125649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CuC4+ZngNgNW0Zh5q0mwTTZqAHz30i50o1NYtueOFcg=;
        b=NsU0MQEnSL3MG1+VVHKFhSwdgujRR3dKusFjCeKHV/ThuGiJ1tBaHuj2/EUeewY0U0FJ7+
        SKBwIwwd3ONa69whplPBpNNLNS/b9WmCfDhzug2c624JMxj+x7zgHwEqbpjvIyNsK0CR40
        wU5pXRQ9Eq0JJo+C9/PUinq3Z8Pxpds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-D8PHff3ROGua8RIAnlGnNA-1; Mon, 18 Nov 2019 20:07:24 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F8F61804985;
        Tue, 19 Nov 2019 01:07:23 +0000 (UTC)
Received: from epycfail.redhat.com (ovpn-112-24.ams2.redhat.com [10.36.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 130C3BA45;
        Tue, 19 Nov 2019 01:07:20 +0000 (UTC)
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>,
        =?UTF-8?q?Kadlecsik=20J=C3=B3zsef?= <kadlec@blackhole.kfki.hu>,
        Eric Garver <eric@garver.life>, Phil Sutter <phil@nwl.cc>
Subject: [PATCH nft 3/3] tests: Introduce test for set with concatenated ranges
Date:   Tue, 19 Nov 2019 02:07:12 +0100
Message-Id: <20191119010712.39316-4-sbrivio@redhat.com>
In-Reply-To: <20191119010712.39316-1-sbrivio@redhat.com>
References: <20191119010712.39316-1-sbrivio@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: D8PHff3ROGua8RIAnlGnNA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This test checks that set elements can be added, deleted, that
addition and deletion are refused when appropriate, that entries
time out properly and they can be fetched by matching values in
the given ranges.

Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
---
 .../testcases/sets/0038concatenated_ranges_0  | 162 ++++++++++++++++++
 1 file changed, 162 insertions(+)
 create mode 100755 tests/shell/testcases/sets/0038concatenated_ranges_0

diff --git a/tests/shell/testcases/sets/0038concatenated_ranges_0 b/tests/s=
hell/testcases/sets/0038concatenated_ranges_0
new file mode 100755
index 00000000..7dfab83e
--- /dev/null
+++ b/tests/shell/testcases/sets/0038concatenated_ranges_0
@@ -0,0 +1,162 @@
+#!/bin/sh -e
+#
+# 0038concatenated_ranges_0 - Add, get, list, timeout for concatenated ran=
ges
+#
+# Cycle over supported data types, forming concatenations of three fields,=
 for
+# all possible permutations, and:
+# - add entries to set
+# - list them
+# - check that they can't be added again
+# - get entries by specifying a value matching ranges for all fields
+# - delete them
+# - add them with 1s timeout
+# - check that they can't be added again right away
+# - check that they are not listed after 1s
+# - delete them
+# - make sure they can't deleted again
+
+TYPES=3D"ipv4_addr ipv6_addr ether_addr inet_proto inet_service mark"
+
+RULESPEC_ipv4_addr=3D"ip saddr"
+ELEMS_ipv4_addr=3D"192.0.2.1 198.51.100.0/25 203.0.113.0-203.0.113.129"
+ADD_ipv4_addr=3D"192.0.2.252/31"
+GET_ipv4_addr=3D"198.51.100.127 198.51.100.0/25"
+
+RULESPEC_ipv6_addr=3D"ip6 daddr"
+ELEMS_ipv6_addr=3D"2001:db8:c0c:c0de::1-2001:db8:cacc::a 2001:db8::1 2001:=
db8:dada:da::-2001:db8:dada:da:ffff:ffff:ffff:ffff"
+ADD_ipv6_addr=3D"2001:db8::d1ca:d1ca"
+GET_ipv6_addr=3D"2001:db8::1 2001:db8::1"
+
+RULESPEC_ether_addr=3D"ether saddr"
+ELEMS_ether_addr=3D"00:0a:c1:d1:f1:ed-00:0a:c1:dd:ec:af 00:0b:0c:ca:cc:10-=
c1:a0:c1:cc:10:00 f0:ca:cc:1a:b0:1a"
+ADD_ether_addr=3D"00:be:1d:ed:ab:e1"
+GET_ether_addr=3D"ac:c1:ac:c0:ce:c0 00:0b:0c:ca:cc:10-c1:a0:c1:cc:10:00"
+
+RULESPEC_inet_proto=3D"meta l4proto"
+ELEMS_inet_proto=3D"tcp udp icmp"
+ADD_inet_proto=3D"sctp"
+GET_inet_proto=3D"udp udp"
+
+RULESPEC_inet_service=3D"tcp dport"
+ELEMS_inet_service=3D"22-23 1024-32768 31337"
+ADD_inet_service=3D"32769-65535"
+GET_inet_service=3D"32768 1024-32768"
+
+RULESPEC_mark=3D"mark"
+ELEMS_mark=3D"0x00000064-0x000000c8 0x0000006f 0x0000fffd-0x0000ffff"
+ADD_mark=3D"0x0000002a"
+GET_mark=3D"0x0000006f 0x0000006f"
+
+tmp=3D"$(mktemp)"
+trap "rm -f ${tmp}" EXIT
+
+render() {
+=09eval "echo \"$(cat ${1})\""
+}
+
+cat <<'EOF' > "${tmp}"
+flush ruleset
+
+table inet filter {
+=09set test {
+=09=09type ${ta} . ${tb} . ${tc}
+=09=09flags interval,timeout
+=09=09elements =3D { ${a1} . ${b1} . ${c1} ,
+=09=09=09     ${a2} . ${b2} . ${c2} ,
+=09=09=09     ${a3} . ${b3} . ${c3} }
+=09}
+
+=09chain output {
+=09=09type filter hook output priority 0; policy accept;
+=09=09${sa} . ${sb} . ${sc} @test counter
+=09}
+}
+EOF
+
+for ta in ${TYPES}; do
+=09eval a=3D\$ELEMS_${ta}
+=09a1=3D${a%% *}; a2=3D$(expr "$a" : ".* \(.*\) .*"); a3=3D${a##* }
+=09eval sa=3D\$RULESPEC_${ta}
+
+=09for tb in ${TYPES}; do
+=09=09[ "${tb}" =3D "${ta}" ] && continue
+=09=09if [ "${tb}" =3D "ipv6_addr" ]; then
+=09=09=09[ "${ta}" =3D "ipv4_addr" ] && continue
+=09=09elif [ "${tb}" =3D "ipv4_addr" ]; then
+=09=09=09[ "${ta}" =3D "ipv6_addr" ] && continue
+=09=09fi
+
+=09=09eval b=3D\$ELEMS_${tb}
+=09=09b1=3D${b%% *}; b2=3D$(expr "$b" : ".* \(.*\) .*"); b3=3D${b##* }
+=09=09eval sb=3D\$RULESPEC_${tb}
+
+=09=09for tc in ${TYPES}; do
+=09=09=09[ "${tc}" =3D "${ta}" ] && continue
+=09=09=09[ "${tc}" =3D "${tb}" ] && continue
+=09=09=09if [ "${tc}" =3D "ipv6_addr" ]; then
+=09=09=09=09[ "${ta}" =3D "ipv4_addr" ] && continue
+=09=09=09=09[ "${tb}" =3D "ipv4_addr" ] && continue
+=09=09=09elif [ "${tc}" =3D "ipv4_addr" ]; then
+=09=09=09=09[ "${ta}" =3D "ipv6_addr" ] && continue
+=09=09=09=09[ "${tb}" =3D "ipv6_addr" ] && continue
+=09=09=09fi
+
+=09=09=09eval c=3D\$ELEMS_${tc}
+=09=09=09c1=3D${c%% *}; c2=3D$(expr "$c" : ".* \(.*\) .*"); c3=3D${c##* }
+=09=09=09eval sc=3D\$RULESPEC_${tc}
+
+=09=09=09render ${tmp} | ${NFT} -f -
+
+=09=09=09[ $(${NFT} list set inet filter test |=09=09\
+=09=09=09   grep -c -e "${a1} . ${b1} . ${c1}"=09=09\
+=09=09=09=09   -e "${a2} . ${b2} . ${c2}"=09=09\
+=09=09=09=09   -e "${a3} . ${b3} . ${c3}") -eq 3 ]
+
+=09=09=09! ${NFT} add element inet filter test \
+=09=09=09=09"{ ${a1} . ${b1} . ${c1} }" 2>/dev/null
+=09=09=09! ${NFT} add element inet filter test \
+=09=09=09=09"{ ${a2} . ${b2} . ${c2} }" 2>/dev/null
+=09=09=09! ${NFT} add element inet filter test \
+=09=09=09=09"{ ${a3} . ${b3} . ${c3} }" 2>/dev/null
+
+=09=09=09${NFT} delete element inet filter test \
+=09=09=09=09"{ ${a1} . ${b1} . ${c1} }"
+=09=09=09! ${NFT} delete element inet filter test \
+=09=09=09=09"{ ${a1} . ${b1} . ${c1} }" 2>/dev/null
+
+=09=09=09eval add_a=3D\$ADD_${ta}
+=09=09=09eval add_b=3D\$ADD_${tb}
+=09=09=09eval add_c=3D\$ADD_${tc}
+=09=09=09${NFT} add element inet filter test \
+=09=09=09=09"{ ${add_a} . ${add_b} . ${add_c} timeout 1s}"
+=09=09=09[ $(${NFT} list set inet filter test |=09=09\
+=09=09=09   grep -c "${add_a} . ${add_b} . ${add_c}") -eq 1 ]
+=09=09=09! ${NFT} add element inet filter test \
+=09=09=09=09"{ ${add_a} . ${add_b} . ${add_c} timeout 1s}" \
+=09=09=09=092>/dev/null
+
+=09=09=09eval get_a=3D\$GET_${ta}
+=09=09=09eval get_b=3D\$GET_${tb}
+=09=09=09eval get_c=3D\$GET_${tc}
+=09=09=09exp_a=3D${get_a##* }; get_a=3D${get_a%% *}
+=09=09=09exp_b=3D${get_b##* }; get_b=3D${get_b%% *}
+=09=09=09exp_c=3D${get_c##* }; get_c=3D${get_c%% *}
+=09=09=09[ $(${NFT} get element inet filter test =09\
+=09=09=09   "{ ${get_a} . ${get_b} . ${get_c} }" |=09\
+=09=09=09   grep -c "${exp_a} . ${exp_b} . ${exp_c}") -eq 1 ]
+
+=09=09=09sleep 1
+=09=09=09[ $(${NFT} list set inet filter test |=09=09\
+=09=09=09   grep -c "${add_a} . ${add_b} . ${add_c}") -eq 0 ]
+
+=09=09=09${NFT} delete element inet filter test \
+=09=09=09=09"{ ${a2} . ${b2} . ${c2} }"
+=09=09=09${NFT} delete element inet filter test \
+=09=09=09=09"{ ${a3} . ${b3} . ${c3} }"
+=09=09=09! ${NFT} delete element inet filter test \
+=09=09=09=09"{ ${a2} . ${b2} . ${c2} }" 2>/dev/null
+=09=09=09! ${NFT} delete element inet filter test \
+=09=09=09=09"{ ${a3} . ${b3} . ${c3} }" 2>/dev/null
+=09=09done
+=09done
+done
--=20
2.23.0

