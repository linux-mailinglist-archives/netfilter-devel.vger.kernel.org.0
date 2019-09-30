Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B01D6C2503
	for <lists+netfilter-devel@lfdr.de>; Mon, 30 Sep 2019 18:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731976AbfI3QUn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 30 Sep 2019 12:20:43 -0400
Received: from correo.us.es ([193.147.175.20]:40386 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbfI3QUn (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 30 Sep 2019 12:20:43 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 9500C3066A3
        for <netfilter-devel@vger.kernel.org>; Mon, 30 Sep 2019 18:20:39 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 88541B8004
        for <netfilter-devel@vger.kernel.org>; Mon, 30 Sep 2019 18:20:39 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 7D32CB7FFB; Mon, 30 Sep 2019 18:20:39 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 61E34DA4CA;
        Mon, 30 Sep 2019 18:20:37 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 30 Sep 2019 18:20:37 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 411E342EF9E1;
        Mon, 30 Sep 2019 18:20:37 +0200 (CEST)
Date:   Mon, 30 Sep 2019 18:20:39 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH v2 03/24] tests: shell: Support running for
 legacy/nft only
Message-ID: <20190930162039.jpc6fr3gvr6tjd4x@salvia>
References: <20190925212605.1005-1-phil@nwl.cc>
 <20190925212605.1005-4-phil@nwl.cc>
 <20190927141901.GD9938@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927141901.GD9938@breakpoint.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Sep 27, 2019 at 04:19:01PM +0200, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > After some changes, one might want to test a single variant only. Allow
> > this by supporting -n/--nft and -l/--legacy parameters, each disabling
> > the other variant.
> 
> Makes sense to me.
> 
> Acked-by: Florian Westphal <fw@strlen.de>

OK, please push out this.
