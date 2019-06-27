Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB8D58AC6
	for <lists+netfilter-devel@lfdr.de>; Thu, 27 Jun 2019 21:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfF0TKi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 27 Jun 2019 15:10:38 -0400
Received: from mail.us.es ([193.147.175.20]:53382 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbfF0TKi (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 27 Jun 2019 15:10:38 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id C1A4DC4145
        for <netfilter-devel@vger.kernel.org>; Thu, 27 Jun 2019 21:10:36 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B2C25DA7B6
        for <netfilter-devel@vger.kernel.org>; Thu, 27 Jun 2019 21:10:36 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id A7F0CDA4D0; Thu, 27 Jun 2019 21:10:36 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 71CB810219C;
        Thu, 27 Jun 2019 21:10:34 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 27 Jun 2019 21:10:34 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 4CB4B4265A31;
        Thu, 27 Jun 2019 21:10:34 +0200 (CEST)
Date:   Thu, 27 Jun 2019 21:10:33 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Ander Juaristi <a@juaristi.eus>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] nftables: meta: time: Proper handling of DST
Message-ID: <20190627191033.2zmcvfmhm2h4y2nb@salvia>
References: <20190626204402.5257-1-a@juaristi.eus>
 <20190626204402.5257-3-a@juaristi.eus>
 <20190626210758.ds5rfelc5ln4pn3r@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626210758.ds5rfelc5ln4pn3r@breakpoint.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jun 26, 2019 at 11:07:58PM +0200, Florian Westphal wrote:
> Ander Juaristi <a@juaristi.eus> wrote:
> 
> same remark, I think this can be squashed.

Agreed.

Ander, please, use git rebase -i (interactive rebased to squash this
patches where they belong).

Thanks!
