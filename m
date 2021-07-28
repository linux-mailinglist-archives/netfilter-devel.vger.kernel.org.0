Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1FB03D8C9E
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 Jul 2021 13:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbhG1LV6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 28 Jul 2021 07:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbhG1LV6 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 28 Jul 2021 07:21:58 -0400
X-Greylist: delayed 321 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 28 Jul 2021 04:21:56 PDT
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5B9C061757;
        Wed, 28 Jul 2021 04:21:56 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 8A01F59708B8C; Wed, 28 Jul 2021 13:16:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 88BA960D3DCF4;
        Wed, 28 Jul 2021 13:16:33 +0200 (CEST)
Date:   Wed, 28 Jul 2021 13:16:33 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Jozsef Kadlecsik <kadlec@netfilter.org>
cc:     netfilter@vger.kernel.org, netfilter-devel@vger.kernel.org
Subject: Re: [ANNOUNCE] ipset 7.13 released
In-Reply-To: <f5d9071-7558-17a-9cd1-6ac0922710@netfilter.org>
Message-ID: <2233nn0-11ns-4o5s-r629-n3n7p0q7r223@vanv.qr>
References: <f5d9071-7558-17a-9cd1-6ac0922710@netfilter.org>
User-Agent: Alpine 2.24 (LSU 510 2020-10-10)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tuesday 2021-07-27 12:35, Jozsef Kadlecsik wrote:
>
>I'm happy to announce ipset 7.13 - 7.12 was released but not announced due 
>to additional fixes required in two patches.

Did you really try building that?

[   19s] Making all in src
[   19s] make[2]: Entering directory '/home/abuild/rpmbuild/BUILD/ipset-7.13/src'
[   19s] gcc -DHAVE_CONFIG_H -I. -I..    -I../include  -std=gnu99  -O2 -DNDEBUG -O2 -Wall -D_FORTIFY_SOURCE=2 -fstack-protector-strong -funwind-tables -fasynchr
onous-unwind-tables -fstack-clash-protection -Werror=return-type  -g -c -o ipset.o ipset.c
[   19s] /bin/sh ../libtool  --tag=CC   --mode=link gcc -std=gnu99  -O2 -DNDEBUG -O2 -Wall -D_FORTIFY_SOURCE=2 -fstack-protector-strong -funwind-tables -fasynch
ronous-unwind-tables -fstack-clash-protection -Werror=return-type  -g   -o ipset ipset.o ../lib/libipset.la
[   19s] libtool: link: gcc -std=gnu99 -O2 -DNDEBUG -O2 -Wall -D_FORTIFY_SOURCE=2 -fstack-protector-strong -funwind-tables -fasynchronous-unwind-tables -fstack-
clash-protection -Werror=return-type -g -o .libs/ipset ipset.o  ../lib/.libs/libipset.so -lmnl -ldl -Wl,-rpath -Wl,/usr/lib64
[   19s] /usr/lib64/gcc/x86_64-suse-linux/11/../../../../x86_64-suse-linux/bin/ld: ipset.o: in function `main':
[   19s] /home/abuild/rpmbuild/BUILD/ipset-7.13/src/ipset.c:35: undefined reference to `ipset_xlate_argv'
[   19s] collect2: error: ld returned 1 exit status

abuild@a4:~/rpmbuild/BUILD/ipset-7.13> readelf -aW lib/.libs/libipset.so.13.2.0 | grep ipset_xlate_argv
   199: 0000000000019c40  4361 FUNC    LOCAL  DEFAULT   15 ipset_xlate_argv

Function not exported, hence link failure.
