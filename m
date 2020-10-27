Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E7229A87B
	for <lists+netfilter-devel@lfdr.de>; Tue, 27 Oct 2020 10:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896477AbgJ0J4S (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 27 Oct 2020 05:56:18 -0400
Received: from correo.us.es ([193.147.175.20]:45254 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896475AbgJ0JzH (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:55:07 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 46C7DC04D1E
        for <netfilter-devel@vger.kernel.org>; Tue, 27 Oct 2020 10:55:05 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 37E2BDA798
        for <netfilter-devel@vger.kernel.org>; Tue, 27 Oct 2020 10:55:05 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 2B5CBDA796; Tue, 27 Oct 2020 10:55:05 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WELCOMELIST,USER_IN_WHITELIST
        autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 91E1DDA72F;
        Tue, 27 Oct 2020 10:55:02 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 27 Oct 2020 10:55:02 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 7523842EF42D;
        Tue, 27 Oct 2020 10:55:02 +0100 (CET)
Date:   Tue, 27 Oct 2020 10:55:02 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     netfilter@vger.kernel.org, netfilter-announce@lists.netfilter.org,
        lwn@lwn.net
Subject: [ANNOUNCE] libnftnl 1.1.8 release
Message-ID: <20201027095502.GA32189@salvia>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi!

The Netfilter project proudly presents:

        libnftnl 1.1.8

libnftnl is a userspace library providing a low-level netlink
programming interface (API) to the in-kernel nf_tables subsystem.
This library is currently used by nftables.

See ChangeLog that comes attached to this email for more details.

You can download it from:

https://www.netfilter.org/projects/libnftnl/downloads.html

Happy firewalling.

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="changes-libnftnl-1.1.8.txt"

Florian Westphal (1):
      libnftnl: export nftnl_set_elem_fprintf

Jose M. Guisado Gomez (5):
      examples: add support for NF_PROTO_INET family
      udata: add NFTNL_UDATA_SET_COMMENT
      table: add userdata support
      object: add userdata and comment support
      chain: add userdata and comment support

Pablo Neira Ayuso (6):
      src: add support for chain ID attribute
      examples: unbreak nft-set-elem-del
      expr: socket: add wildcard support
      expr: expose nftnl_expr_build_payload()
      expr: add nftnl_rule_del_expr()
      build: libnftnl 1.1.8 release


--4Ckj6UjgE2iN1+kY--
