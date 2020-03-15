Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8E30185D94
	for <lists+netfilter-devel@lfdr.de>; Sun, 15 Mar 2020 15:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgCOObU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 15 Mar 2020 10:31:20 -0400
Received: from correo.us.es ([193.147.175.20]:47076 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727399AbgCOObT (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 15 Mar 2020 10:31:19 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 0AED112BFFC
        for <netfilter-devel@vger.kernel.org>; Sun, 15 Mar 2020 15:30:52 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id F0752DA3A3
        for <netfilter-devel@vger.kernel.org>; Sun, 15 Mar 2020 15:30:51 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id E6025DA3A0; Sun, 15 Mar 2020 15:30:51 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 41955DA72F;
        Sun, 15 Mar 2020 15:30:50 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sun, 15 Mar 2020 15:30:50 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 24CA44251480;
        Sun, 15 Mar 2020 15:30:50 +0100 (CET)
Date:   Sun, 15 Mar 2020 15:31:15 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next 1/1] netfilter: conntrack: re-visit sysctls in
 unprivileged namespaces
Message-ID: <20200315143115.jd7qmhtd27kqzyge@salvia>
References: <20200311195201.18738-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311195201.18738-1-fw@strlen.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Mar 11, 2020 at 08:52:01PM +0100, Florian Westphal wrote:
> since commit b884fa46177659 ("netfilter: conntrack: unify sysctl handling")
> conntrack no longer exposes most of its sysctls (e.g. tcp timeouts
> settings) to network namespaces that are not owned by the initial user
> namespace.
> 
> This patch exposes all sysctls even if the namespace is unpriviliged.

Applied, thanks.
