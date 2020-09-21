Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8C627368D
	for <lists+netfilter-devel@lfdr.de>; Tue, 22 Sep 2020 01:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbgIUXSB (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 21 Sep 2020 19:18:01 -0400
Received: from correo.us.es ([193.147.175.20]:53650 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728712AbgIUXSB (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 21 Sep 2020 19:18:01 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 92B2111772A
        for <netfilter-devel@vger.kernel.org>; Tue, 22 Sep 2020 01:18:00 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 8391DDA72F
        for <netfilter-devel@vger.kernel.org>; Tue, 22 Sep 2020 01:18:00 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 787EFDA722; Tue, 22 Sep 2020 01:18:00 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 6860CDA704;
        Tue, 22 Sep 2020 01:17:58 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 22 Sep 2020 01:17:58 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 4BDF042EF4E0;
        Tue, 22 Sep 2020 01:17:58 +0200 (CEST)
Date:   Tue, 22 Sep 2020 01:17:58 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     "Jose M. Guisado Gomez" <guigom@riseup.net>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nftables] parser_bison: fail when specifying multiple
 comments
Message-ID: <20200921231758.GA6138@salvia>
References: <20200910164019.86192-1-guigom@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200910164019.86192-1-guigom@riseup.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Sep 10, 2020 at 06:40:20PM +0200, Jose M. Guisado Gomez wrote:
> Before this patch grammar supported specifying multiple comments, and
> only the last value would be assigned.
> 
> This patch adds a function to test if an attribute is already assigned
> and, if so, calls erec_queue with this attribute location.
> 
> Use this function in order to check for duplication (or more) of comments
> for actions that support it.
> 
> > nft add table inet filter { flags "dormant"\; comment "test"\; comment "another"\;}
> 
> Error: You can only specify this once. This statement is duplicated.
> add table inet filter { flags dormant; comment test; comment another;}
>                                                      ^^^^^^^^^^^^^^^^

Applied, thanks.
