Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99596624586
	for <lists+netfilter-devel@lfdr.de>; Thu, 10 Nov 2022 16:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiKJPVe (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 10 Nov 2022 10:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiKJPVd (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:21:33 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17FB82A724;
        Thu, 10 Nov 2022 07:21:31 -0800 (PST)
Date:   Thu, 10 Nov 2022 16:21:28 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     netfilter@vger.kernel.org, netfilter-announce@lists.netfilter.org,
        lwn@lwn.net
Subject: [ANNOUNCE] libnftnl 1.2.4 release
Message-ID: <Y20W+LT/+sq/i2rz@salvia>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="RdtRELJTBSCF7X6r"
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


--RdtRELJTBSCF7X6r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi!

The Netfilter project proudly presents:

        libnftnl 1.2.4

libnftnl is a userspace library providing a low-level netlink
programming interface (API) to the in-kernel nf_tables subsystem.
This library is currently used by nftables.

This release includes two fixes for the printing of the set element
user data area and the removal of an internal function without any
clients.

This release also includes a fix for the nfnetlink .res_id incorrect
endianess. Note that there is a workaround in the kernel that has been
available for a while which is present in -stable releases:

 commit a9de9777d613500b089a7416f936bf3ae5f070d2
 Author: Pablo Neira Ayuso <pablo@netfilter.org>
 Date:   Fri Aug 28 21:01:43 2015 +0200

    netfilter: nfnetlink: work around wrong endianess in res_id field

Old Linux kernel versions <= 4.9 might break without the above
kernel patch since libnftnl >= 1.2.4.

See ChangeLog that comes attached to this email for more details on
the updates.

You can download it from:

https://www.netfilter.org/projects/libnftnl/downloads.html

Happy firewalling.

--RdtRELJTBSCF7X6r
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="changes-libnftnl-1.2.4.txt"

Ian Pilcher (1):
      libnftnl: Fix res_id byte order

Jeremy Sowden (1):
      rule, set_elem: fix printing of user data

Pablo Neira Ayuso (3):
      rule, set_elem: remove trailing \n in userdata snprintf
      expr: payload: remove unused function
      build: libnftnl 1.2.4 release


--RdtRELJTBSCF7X6r--
