Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3346F7FB
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Apr 2019 14:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbfD3Lmp (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 30 Apr 2019 07:42:45 -0400
Received: from mail.us.es ([193.147.175.20]:46586 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729473AbfD3Lmp (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:42:45 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 438E79A7B3
        for <netfilter-devel@vger.kernel.org>; Tue, 30 Apr 2019 13:42:43 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 3319CDA70F
        for <netfilter-devel@vger.kernel.org>; Tue, 30 Apr 2019 13:42:43 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 285ABDA710; Tue, 30 Apr 2019 13:42:43 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 1578EDA710;
        Tue, 30 Apr 2019 13:42:41 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 30 Apr 2019 13:42:41 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (129.166.216.87.static.jazztel.es [87.216.166.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id D022D40705C1;
        Tue, 30 Apr 2019 13:42:40 +0200 (CEST)
Date:   Tue, 30 Apr 2019 13:42:40 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Flavio Leitner <fbl@redhat.com>
Cc:     netdev@vger.kernel.org, Joe Stringer <joe@ovn.org>,
        Pravin B Shelar <pshelar@ovn.org>, dev@openvswitch.org,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/4] openvswitch: load and reference the NAT
 helper
Message-ID: <20190430114240.bpqseexjjcr6s4ta@salvia>
References: <20190417144617.14922-1-fbl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417144617.14922-1-fbl@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Apr 17, 2019 at 11:46:13AM -0300, Flavio Leitner wrote:
> The request_module() is quite expensive and triggers the
> usermode helper in userspace. Instead, load only if the
> module is not present and keep module references to avoid
> problems.
> 
> The first patch standardize the module alias which is already
> there, but not in a formal way.
> 
> The second patch adds an API to point to the NAT helper.
> 
> The third patch will register each NAT helper using the
> new API.
> 
> The last patch fixes openvswitch to use the new API to
> load and reference the NAT helper and also report an error
> if the operation fails.

Series applied. Thanks Flavio.
