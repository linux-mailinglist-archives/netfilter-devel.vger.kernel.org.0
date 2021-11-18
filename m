Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8B3455958
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Nov 2021 11:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245760AbhKRKtJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 18 Nov 2021 05:49:09 -0500
Received: from mail.netfilter.org ([217.70.188.207]:43142 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245756AbhKRKtB (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 18 Nov 2021 05:49:01 -0500
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id E7860625F6;
        Thu, 18 Nov 2021 11:43:53 +0100 (CET)
Date:   Thu, 18 Nov 2021 11:45:55 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     netfilter@vger.kernel.org, netfilter-announce@lists.netfilter.org,
        lwn@lwn.net
Subject: [ANNOUNCE] libnftnl 1.2.1 release
Message-ID: <YZYu487P9hhbYtUS@salvia>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="CIeVzyNoEvK+XNBk"
Content-Disposition: inline
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


--CIeVzyNoEvK+XNBk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi!

The Netfilter project proudly presents:

        libnftnl 1.2.1

libnftnl is a userspace library providing a low-level netlink
programming interface (API) to the in-kernel nf_tables subsystem.
This library is currently used by nftables.

See ChangeLog that comes attached to this email for more details.

You can download it from:

https://www.netfilter.org/projects/libnftnl/downloads.html
https://www.netfilter.org/pub/libnftnl/

Happy firewalling.

--CIeVzyNoEvK+XNBk
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="changes-libnftnl-1.2.1.txt"

Pablo Neira Ayuso (8):
      include: update nf_tables.h
      expr: add last match time support
      expr: missing netlink attribute in last expression
      expr: last: add NFTNL_EXPR_LAST_SET
      set: expose nftnl_set_elem_nlmsg_build()
      set: use NFTNL_SET_ELEM_VERDICT to print verdict
      expr: payload: print inner header base offset
      build: libnftnl 1.2.1 release


--CIeVzyNoEvK+XNBk--
