Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34397EB094
	for <lists+netfilter-devel@lfdr.de>; Thu, 31 Oct 2019 13:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfJaMtZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 31 Oct 2019 08:49:25 -0400
Received: from correo.us.es ([193.147.175.20]:33710 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbfJaMtZ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 31 Oct 2019 08:49:25 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 9793D4A706A
        for <netfilter-devel@vger.kernel.org>; Thu, 31 Oct 2019 13:49:20 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 88A25B7FF6
        for <netfilter-devel@vger.kernel.org>; Thu, 31 Oct 2019 13:49:20 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 7E36CB7FF9; Thu, 31 Oct 2019 13:49:20 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A74EC2DC8F;
        Thu, 31 Oct 2019 13:49:18 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 31 Oct 2019 13:49:18 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 84E8342EE38E;
        Thu, 31 Oct 2019 13:49:18 +0100 (CET)
Date:   Thu, 31 Oct 2019 13:49:20 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [libnftnl PATCH 2/2] Deprecate untyped data setters
Message-ID: <20191031124920.4p2frkvfwgktaxqz@salvia>
References: <20191030174948.12493-1-phil@nwl.cc>
 <20191030174948.12493-2-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030174948.12493-2-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Oct 30, 2019 at 06:49:48PM +0100, Phil Sutter wrote:
> These functions make assumptions on size of passed data pointer and
> therefore tend to hide programming mistakes. Instead either one of the
> type-specific setters or the generic *_set_data() setter should be used.

Please, confirm that the existing iptables / nft codebase will not hit
compilation warnings because of deprecated functions.

Thanks.
