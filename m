Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D81FD4EC72
	for <lists+netfilter-devel@lfdr.de>; Fri, 21 Jun 2019 17:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfFUPqG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 21 Jun 2019 11:46:06 -0400
Received: from mail.us.es ([193.147.175.20]:54362 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfFUPqG (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 21 Jun 2019 11:46:06 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id A09BAEDB01
        for <netfilter-devel@vger.kernel.org>; Fri, 21 Jun 2019 17:46:04 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 91685DA701
        for <netfilter-devel@vger.kernel.org>; Fri, 21 Jun 2019 17:46:04 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 87069DA706; Fri, 21 Jun 2019 17:46:04 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 766E6DA701;
        Fri, 21 Jun 2019 17:46:02 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 21 Jun 2019 17:46:02 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 559284265A31;
        Fri, 21 Jun 2019 17:46:02 +0200 (CEST)
Date:   Fri, 21 Jun 2019 17:46:01 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Laura Garcia Liebana <nevola@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnftnl] src: enable set expiration date for set elements
Message-ID: <20190621154601.aqbw4kez6wih5t5k@salvia>
References: <20190617161505.cm2xxqa26aegbmkr@nevthink>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617161505.cm2xxqa26aegbmkr@nevthink>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Jun 17, 2019 at 06:15:05PM +0200, Laura Garcia Liebana wrote:
> Currently, the expiration of every element in a set or map
> is a read-only parameter generated at kernel side.
> 
> This change will permit to set a certain expiration date
> per element that will be required, for example, during
> stateful replication among several nodes.
> 
> This patch allows to propagate NFTA_SET_ELEM_EXPIRATION
> from userspace to the kernel in order to set the
> configured value.

Applied, thanks Laura.
