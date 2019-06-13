Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B19A143C09
	for <lists+netfilter-devel@lfdr.de>; Thu, 13 Jun 2019 17:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbfFMPdi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 13 Jun 2019 11:33:38 -0400
Received: from mail.us.es ([193.147.175.20]:58826 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728378AbfFMKlT (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 13 Jun 2019 06:41:19 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id CF70111F022
        for <netfilter-devel@vger.kernel.org>; Thu, 13 Jun 2019 12:41:17 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C102CDA709
        for <netfilter-devel@vger.kernel.org>; Thu, 13 Jun 2019 12:41:17 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id B6788DA706; Thu, 13 Jun 2019 12:41:17 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B5766DA704;
        Thu, 13 Jun 2019 12:41:15 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 13 Jun 2019 12:41:15 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 9232B4265A32;
        Thu, 13 Jun 2019 12:41:15 +0200 (CEST)
Date:   Thu, 13 Jun 2019 12:41:15 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] monitor: Accept -j flag
Message-ID: <20190613104115.yquqdhrafi4pdwjx@salvia>
References: <20190612172737.26214-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612172737.26214-1-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jun 12, 2019 at 07:27:37PM +0200, Phil Sutter wrote:
> Make 'nft -j monitor' equal to 'nft monitor json' and change
> documentation to use only the first variant since that is more intuitive
> and also consistent with other commands.
> 
> While being at it, drop references to XML from monitor section - it was
> never supported.

Applied, thanks Phil.
