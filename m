Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5EA4255FA9
	for <lists+netfilter-devel@lfdr.de>; Fri, 28 Aug 2020 19:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgH1RWh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 28 Aug 2020 13:22:37 -0400
Received: from correo.us.es ([193.147.175.20]:54814 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726995AbgH1RWh (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 28 Aug 2020 13:22:37 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 2A3071C4367
        for <netfilter-devel@vger.kernel.org>; Fri, 28 Aug 2020 19:22:36 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 1CC34DA78A
        for <netfilter-devel@vger.kernel.org>; Fri, 28 Aug 2020 19:22:36 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 125CBDA789; Fri, 28 Aug 2020 19:22:36 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 0D51BDA722;
        Fri, 28 Aug 2020 19:22:34 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 28 Aug 2020 19:22:34 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id DBAC242EF4E1;
        Fri, 28 Aug 2020 19:22:33 +0200 (CEST)
Date:   Fri, 28 Aug 2020 19:22:33 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Michael Zhou <mzhou@cse.unsw.edu.au>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v2] net/ipv6/netfilter/ip6t_NPT: rewrite addresses in
 ICMPv6 original packet
Message-ID: <20200828172233.GB6651@salvia>
References: <20200806151524.12112-1-mzhou@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200806151524.12112-1-mzhou@cse.unsw.edu.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Aug 07, 2020 at 01:15:25AM +1000, Michael Zhou wrote:
> Detect and rewrite a prefix embedded in an ICMPv6 original packet that was
> rewritten by a corresponding DNPT/SNPT rule so it will be recognised by
> the host that sent the original packet.

Applied, thanks.
