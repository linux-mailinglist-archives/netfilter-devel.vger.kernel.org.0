Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 730DE143D68
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Jan 2020 13:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgAUM5v (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 21 Jan 2020 07:57:51 -0500
Received: from correo.us.es ([193.147.175.20]:36138 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729044AbgAUM5u (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 21 Jan 2020 07:57:50 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id D9E661878AE
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Jan 2020 13:57:48 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C9C4DDA718
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Jan 2020 13:57:48 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id BCCB8DA715; Tue, 21 Jan 2020 13:57:48 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A6BEFDA701;
        Tue, 21 Jan 2020 13:57:46 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 21 Jan 2020 13:57:46 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 89F2442EE38F;
        Tue, 21 Jan 2020 13:57:46 +0100 (CET)
Date:   Tue, 21 Jan 2020 13:57:45 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH 4/4] netlink: Avoid potential NULL-pointer deref in
 netlink_gen_payload_stmt()
Message-ID: <20200121125745.xd7rcprheeg4zer3@salvia>
References: <20200120162540.9699-1-phil@nwl.cc>
 <20200120162540.9699-5-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120162540.9699-5-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Jan 20, 2020 at 05:25:40PM +0100, Phil Sutter wrote:
> With payload_needs_l4csum_update_pseudohdr() unconditionally
> dereferencing passed 'desc' parameter and a previous check for it to be
> non-NULL, make sure to call the function only if input is sane.
> 
> Fixes: 68de70f2b3fc6 ("netlink_linearize: fix IPv6 layer 4 checksum mangling")
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>

Thanks.
