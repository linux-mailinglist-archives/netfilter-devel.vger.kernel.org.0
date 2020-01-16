Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 580ED13DDFE
	for <lists+netfilter-devel@lfdr.de>; Thu, 16 Jan 2020 15:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgAPOvn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 16 Jan 2020 09:51:43 -0500
Received: from correo.us.es ([193.147.175.20]:55516 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbgAPOvn (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 16 Jan 2020 09:51:43 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 084A04FFE02
        for <netfilter-devel@vger.kernel.org>; Thu, 16 Jan 2020 15:51:42 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id EDE26DA707
        for <netfilter-devel@vger.kernel.org>; Thu, 16 Jan 2020 15:51:41 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id E3752DA711; Thu, 16 Jan 2020 15:51:41 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id ED8A5DA707;
        Thu, 16 Jan 2020 15:51:39 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 16 Jan 2020 15:51:39 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id D07D242EF9E1;
        Thu, 16 Jan 2020 15:51:39 +0100 (CET)
Date:   Thu, 16 Jan 2020 15:51:39 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nf-next] netfilter: nft_bitwise: correct uapi header
 comment.
Message-ID: <20200116145139.j6q64x2un5h4ambs@salvia>
References: <20200101134132.169496-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200101134132.169496-1-jeremy@azazel.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jan 01, 2020 at 01:41:32PM +0000, Jeremy Sowden wrote:
> The comment documenting how bitwise expressions work includes a table
> which summarizes the mask and xor arguments combined to express the
> supported boolean operations.  However, the row for OR:
> 
>  mask    xor
>  0       x
> 
> is incorrect.
> 
>   dreg = (sreg & 0) ^ x
> 
> is not equivalent to:
> 
>   dreg = sreg | x
> 
> What the code actually does is:
> 
>   dreg = (sreg & ~x) ^ x
> 
> Update the documentation to match.

Applied, thanks.
