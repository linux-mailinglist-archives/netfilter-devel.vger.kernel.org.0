Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBE5860AF
	for <lists+netfilter-devel@lfdr.de>; Thu,  8 Aug 2019 13:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730747AbfHHLQt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 8 Aug 2019 07:16:49 -0400
Received: from correo.us.es ([193.147.175.20]:42506 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730722AbfHHLQt (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 8 Aug 2019 07:16:49 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 02160B6329
        for <netfilter-devel@vger.kernel.org>; Thu,  8 Aug 2019 13:16:47 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E62931150D8
        for <netfilter-devel@vger.kernel.org>; Thu,  8 Aug 2019 13:16:46 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id DA6CBDA72F; Thu,  8 Aug 2019 13:16:46 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D8962DA72F;
        Thu,  8 Aug 2019 13:16:44 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 08 Aug 2019 13:16:44 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (149.103.108.93.rev.vodafone.pt [93.108.103.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 404A64265A2F;
        Thu,  8 Aug 2019 13:16:44 +0200 (CEST)
Date:   Thu, 8 Aug 2019 13:16:34 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Brett Mastbergen <bmastbergen@untangle.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft v2] src: Support maps as left side expressions
Message-ID: <20190808111634.quczq7ajnaobscab@salvia>
References: <20190730122818.2032-1-bmastbergen@untangle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730122818.2032-1-bmastbergen@untangle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi brett,

On Tue, Jul 30, 2019 at 08:28:18AM -0400, Brett Mastbergen wrote:
> This change allows map expressions on the left side of comparisons:
> 
> nft add rule foo bar ip saddr map @map_a == 22 counter
> 
> It also allows map expressions as the left side expression of other
> map expressions:
> 
> nft add rule foo bar ip saddr map @map_a map @map_b == 22 counter

This is an interesting usage of the maps from the left-hand side of an
expression.

I have a fundamental question, that is, how this will be used from
rulesets? My impression is that this will result in many rules, e.g.

        ip saddr map @map_a map @map_b == 22 accept
        ip saddr map @map_a map @map_b == 21 drop
        ip saddr map @map_a map @map_b == 20 jump chain_0
        ...

This means that we need one rule per map lookup.

I think this feature will be more useful if this can be combined with
verdict maps, so the right hand side could be used to look up for an
action.

Thanks.
