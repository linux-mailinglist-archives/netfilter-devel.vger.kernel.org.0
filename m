Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F585175BB4
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Mar 2020 14:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgCBNds (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Mar 2020 08:33:48 -0500
Received: from correo.us.es ([193.147.175.20]:50508 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728141AbgCBNds (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Mar 2020 08:33:48 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 4E2B711EB23
        for <netfilter-devel@vger.kernel.org>; Mon,  2 Mar 2020 14:33:34 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 3FF3FDA3A0
        for <netfilter-devel@vger.kernel.org>; Mon,  2 Mar 2020 14:33:34 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 35514DA38D; Mon,  2 Mar 2020 14:33:34 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5DA24DA3C2;
        Mon,  2 Mar 2020 14:33:32 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 02 Mar 2020 14:33:32 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 3D562426CCB9;
        Mon,  2 Mar 2020 14:33:32 +0100 (CET)
Date:   Mon, 2 Mar 2020 14:33:44 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Florian Westphal <fw@strlen.de>,
        Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH libnftnl 0/3] bitwise: support for passing mask and xor
 via registers
Message-ID: <20200302133344.gt5gqnadpsr2hlqc@salvia>
References: <20200224131201.512755-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224131201.512755-1-jeremy@azazel.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Feb 24, 2020 at 01:11:58PM +0000, Jeremy Sowden wrote:
> The kernel supports passing mask and xor values for bitwise boolean
> operations via registers.  These are mutually exclusive with the
> existing data attributes: e.g., setting both NFTA_EXPR_BITWISE_MASK and
> NFTA_EXPR_BITWISE_MREG is an error.  Add support to libnftnl.
> 
> The first patch fixes a typo, the second updates the UAPI header and
> the last contains the implementation.

Applied, thanks.
