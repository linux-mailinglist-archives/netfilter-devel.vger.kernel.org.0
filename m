Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D70F817DE48
	for <lists+netfilter-devel@lfdr.de>; Mon,  9 Mar 2020 12:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgCILLD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 9 Mar 2020 07:11:03 -0400
Received: from correo.us.es ([193.147.175.20]:49240 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbgCILLD (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 9 Mar 2020 07:11:03 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 5757FEF43E
        for <netfilter-devel@vger.kernel.org>; Mon,  9 Mar 2020 12:10:42 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 444B3DA3A1
        for <netfilter-devel@vger.kernel.org>; Mon,  9 Mar 2020 12:10:42 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 43516DA39F; Mon,  9 Mar 2020 12:10:42 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 21978DA38D;
        Mon,  9 Mar 2020 12:10:39 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 09 Mar 2020 12:10:39 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id D6E0842EE396;
        Mon,  9 Mar 2020 12:10:38 +0100 (CET)
Date:   Mon, 9 Mar 2020 12:10:58 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft] parser_bison: fix rshift statement expression.
Message-ID: <20200309111058.x5vmz2yz2nx5yzhc@salvia>
References: <20200309110747.155907-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309110747.155907-1-jeremy@azazel.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Mar 09, 2020 at 11:07:47AM +0000, Jeremy Sowden wrote:
> The RHS of RSHIFT statement expressions should be primary_stmt_expr, not
> primary_rhs_expr.

Applied, thanks.
