Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1DDEB23E
	for <lists+netfilter-devel@lfdr.de>; Thu, 31 Oct 2019 15:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfJaONU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 31 Oct 2019 10:13:20 -0400
Received: from correo.us.es ([193.147.175.20]:48420 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbfJaONT (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 31 Oct 2019 10:13:19 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 0FE6311EB34
        for <netfilter-devel@vger.kernel.org>; Thu, 31 Oct 2019 15:13:15 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 025F7DA4CA
        for <netfilter-devel@vger.kernel.org>; Thu, 31 Oct 2019 15:13:15 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id EC36EDA801; Thu, 31 Oct 2019 15:13:14 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 11888B7FF6;
        Thu, 31 Oct 2019 15:13:13 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 31 Oct 2019 15:13:13 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id E2C2E42EE393;
        Thu, 31 Oct 2019 15:13:12 +0100 (CET)
Date:   Thu, 31 Oct 2019 15:13:14 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH v3 00/12] Implement among match support
Message-ID: <20191031141314.u5fvw4djza25er44@salvia>
References: <20191030172701.5892-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030172701.5892-1-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Oct 30, 2019 at 06:26:49PM +0100, Phil Sutter wrote:
[...]
> Patches 1 to 5 implement required changes and are rather boring by
> themselves: When converting an nftnl rule to iptables command state,
> cache access is required (to lookup set references).

nft_handle is passed now all over the place, this allows anyone to
access all of its content. This layering design was done on purpose,
to avoid giving access to all information to the callers, instead
force the developer to give a reason to show why it needs something
else from wherever he is. I'm not entirely convinced exposing the
handle everywhere just because you need to access the set cache is the
way to go.
