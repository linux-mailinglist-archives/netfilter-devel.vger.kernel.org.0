Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F28F3220D2
	for <lists+netfilter-devel@lfdr.de>; Mon, 22 Feb 2021 21:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhBVUbf (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 22 Feb 2021 15:31:35 -0500
Received: from mout.gmx.net ([212.227.17.22]:48201 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230194AbhBVUbe (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 22 Feb 2021 15:31:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614025802;
        bh=GeO0Zy3VRNNH8CtaIziybUr3k8BkwS4BGfoexmMBh9M=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=adCqwKwxz+pbJFIA2CbwE+btDeaP7WLGScqxiYS/uM3i69fM4nBoyV7OYrr0kKriy
         rL+NgQoOEg0/Xyy+MdfJg/K0na4YQe7mElCJA7sbyE3ugIpfO/d0ro0W1qS2YzoHcs
         7dT7aUACjx5swmwqyflf+xBBmICksnAA82ChPxcA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.23] ([95.112.83.240]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0Fxf-1m0b4n2ksR-00xMo4 for
 <netfilter-devel@vger.kernel.org>; Mon, 22 Feb 2021 21:30:02 +0100
To:     netfilter-devel@vger.kernel.org
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Subject: increasing ip_list_tot in net/netfilter/xt_recent.c for a non-modular
 kernel
Message-ID: <df5eb9af-568a-ef0e-bc4f-33b0fbe1307f@gmx.de>
Date:   Mon, 22 Feb 2021 21:30:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+I/4xMs/ecDLssNEarWh3ktD4Uyez4nSrazZs4ILf4ByDQ4z+/A
 EqGtQtt1XHsyYFJVEBq5yxvkv7VACsOiXo5pGOgKiLm+ltLH4Ng5Sk4loxhQ4ZRiFKWYwT4
 xaXIDRFCn+4TzGDa2KPo1lwgWCwCudlqFwqabjeMZa9f4Bjex/lFvaZFiYf6muMedIxTpcn
 hf7sXy4wu5muNf1vJFLxA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AcS7LmzHxD8=:QDgpf+8mbmuFBh09Q6pT2C
 VzkX3pTe9HOTueoguqZjdMP6VHI/QPvPOfYCfyD6gCHz1vymdwRg3eyauihuVkdaZA03ZjMso
 p1ntABHpBZa76sH8pdqQHYFbLKZCKpwNI0bkUjEvVAE1o2lTz916e/w+2M5jVxcdmzzpvA1H/
 q1Pii6XMTyXBSsfguMsHRd5GomDL3beGdBGXhupNi06RPx05i5IFr2SU1GDDM/1YlaeWJGyeu
 awReOY/U8MNi62u6Yc1GzTXwTJc1EnG1iJECshzpCQYtJMAwuzYG0bWyEbEv89/uL83RFIm2m
 QwxRYR2aTdyZfN91kJYsHUhgaDULOe346SvyxsyQz46Wtlja2d6YGKkRu3YIraEpzWI7f7H+5
 Ogl3PdSZFNpCKPAI2yC/vAhBwcjK4XLpN/4cilkppLjc2Lh4cEA3H9Yv93CDuPZT/kuadX8Pb
 90e8rqG0DrrfvA6fgXKS7fIBS8zu+BNUL16xtlqKcZku6WZ7ZDqORF3VnVNqTvR8v4ZxcupkL
 psq/MHF8rCXDfWq/Zg8FgyhQ/IJovJ+psqm/XqSziigf3CVtylUeg/XLvyY4sZev2cGPf83p7
 iiM0kE73GqqVqdWDehTY6IZHhxUw2yJan+wiBObwDyGxxlZvrfSxDlIdfwRj+OQs9SboKHJhY
 7/kJ5zQ93vr4demr8dmEu0CO/j3/DBvwE6O+ZI5XDeBHt8cZ4qFVAuJHQ3n953kMMc0wqVqm5
 GV5T4zCe6WxehN+JpGP+6EevtU6isNSfw5RMlTagdnr22ENYvLl1OTK/uGRrG4X0P3At0TShO
 1pF+MxROmzFeBuXErt9pImc3gN1dXFJJh4vT1KSJoc8CxsWLpFU3EAiHE1R4u0n2V/NxOkjA4
 2nhwh2ucjrUZ9cKZICUg==
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

I'm curious if there's a better solution than local patching like:

diff --git a/net/netfilter/xt_recent.c b/net/netfilter/xt_recent.c
index 0446307516cd..e482d4a3fadf 100644
=2D-- a/net/netfilter/xt_recent.c
+++ b/net/netfilter/xt_recent.c
@@ -40,7 +40,7 @@ MODULE_LICENSE("GPL");
  MODULE_ALIAS("ipt_recent");
  MODULE_ALIAS("ip6t_recent");

-static unsigned int ip_list_tot __read_mostly =3D 100;
+static unsigned int ip_list_tot __read_mostly =3D 10000;
  static unsigned int ip_list_hash_size __read_mostly;
  static unsigned int ip_list_perms __read_mostly =3D 0644;
  static unsigned int ip_list_uid __read_mostly;

here under a hardened Gentoo Linux using iptables ?

=2D-
Toralf
