Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A57BD921AC
	for <lists+netfilter-devel@lfdr.de>; Mon, 19 Aug 2019 12:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfHSKu0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 19 Aug 2019 06:50:26 -0400
Received: from correo.us.es ([193.147.175.20]:58906 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbfHSKu0 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 19 Aug 2019 06:50:26 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 69DA9130E2B
        for <netfilter-devel@vger.kernel.org>; Mon, 19 Aug 2019 12:50:23 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5AA5ECA0F3
        for <netfilter-devel@vger.kernel.org>; Mon, 19 Aug 2019 12:50:23 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 502C6CE39D; Mon, 19 Aug 2019 12:50:23 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 4E9CEDA7B6;
        Mon, 19 Aug 2019 12:50:21 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 19 Aug 2019 12:50:21 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [31.4.181.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 04B384265A2F;
        Mon, 19 Aug 2019 12:50:20 +0200 (CEST)
Date:   Mon, 19 Aug 2019 12:50:19 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Juliana Rodrigueiro <juliana.rodrigueiro@intra2net.com>
Cc:     netfilter-devel@vger.kernel.org, fw@strlen.de
Subject: Re: [PATCH v2] netfilter: nfacct: Fix alignment mismatch in
 xt_nfacct_match_info
Message-ID: <20190819105019.7woggt356yy76nfp@salvia>
References: <7899070.tJGA48rBTd@rocinante.m.i2n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7899070.tJGA48rBTd@rocinante.m.i2n>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Aug 16, 2019 at 05:02:22PM +0200, Juliana Rodrigueiro wrote:
> When running a 64-bit kernel with a 32-bit iptables binary, the size of
> the xt_nfacct_match_info struct diverges.
> 
>     kernel: sizeof(struct xt_nfacct_match_info) : 40
>     iptables: sizeof(struct xt_nfacct_match_info)) : 36
> 
> Trying to append nfacct related rules results in an unhelpful message.
> Although it is suggested to look for more information in dmesg, nothing
> can be found there.
> 
>     # iptables -A <chain> -m nfacct --nfacct-name <acct-object>
>     iptables: Invalid argument. Run `dmesg' for more information.
> 
> This patch fixes the memory misalignment by enforcing 8-byte alignment
> within the struct's first revision. This solution is often used in many
> other uapi netfilter headers.

Applied, thanks.

Please, send us the userspace chunk for iptables. Thanks again.
