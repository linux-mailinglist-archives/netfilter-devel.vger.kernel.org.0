Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B316FDBF8
	for <lists+netfilter-devel@lfdr.de>; Fri, 15 Nov 2019 12:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfKOLI4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 15 Nov 2019 06:08:56 -0500
Received: from correo.us.es ([193.147.175.20]:33390 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbfKOLI4 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 15 Nov 2019 06:08:56 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id AF82A120823
        for <netfilter-devel@vger.kernel.org>; Fri, 15 Nov 2019 12:08:51 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A2232A7E16
        for <netfilter-devel@vger.kernel.org>; Fri, 15 Nov 2019 12:08:51 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id A17EAA7E1F; Fri, 15 Nov 2019 12:08:51 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E9777A7E16;
        Fri, 15 Nov 2019 12:08:45 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 15 Nov 2019 12:08:45 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id C3C3E4251481;
        Fri, 15 Nov 2019 12:08:45 +0100 (CET)
Date:   Fri, 15 Nov 2019 12:08:47 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH 2/2] nft: Fix -Z for rules with NFTA_RULE_COMPAT
Message-ID: <20191115110847.pkh6plco6vnike5p@salvia>
References: <20191115094725.19756-1-phil@nwl.cc>
 <20191115094725.19756-3-phil@nwl.cc>
 <20191115102922.GK19558@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115102922.GK19558@breakpoint.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Nov 15, 2019 at 11:29:22AM +0100, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > The special nested attribute NFTA_RULE_COMPAT holds information about
> > any present l4proto match (given via '-p' parameter) in input. The match
> > is contained as meta expression as well, but some xtables extensions
> > explicitly check it's value (see e.g. xt_TPROXY).
> > 
> > This nested attribute is input only, the information is lost after
> > parsing (and initialization of compat extensions). So in order to feed a
> > rule back to kernel with zeroed counters, the attribute has to be
> > reconstructed based on the rule's expressions.
> > 
> > Other code paths are not affected since rule_to_cs() callback will
> > populate respective fields in struct iptables_command_state and 'add'
> > callback (which is the inverse to rule_to_cs()) calls add_compat() in
> > any case.
> 
> Reviewed-by: Florian Westphal <fw@strlen.de>

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org> 
