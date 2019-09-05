Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76BBCAA134
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Sep 2019 13:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388348AbfIELWw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 5 Sep 2019 07:22:52 -0400
Received: from correo.us.es ([193.147.175.20]:52608 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388335AbfIELWv (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 5 Sep 2019 07:22:51 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id BA65D120825
        for <netfilter-devel@vger.kernel.org>; Thu,  5 Sep 2019 13:22:47 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id AB9AEB7FF6
        for <netfilter-devel@vger.kernel.org>; Thu,  5 Sep 2019 13:22:47 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id AAC0FDA72F; Thu,  5 Sep 2019 13:22:47 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 8EA2BB7FF2;
        Thu,  5 Sep 2019 13:22:45 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 05 Sep 2019 13:22:44 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 5CAC042EE38F;
        Thu,  5 Sep 2019 13:22:45 +0200 (CEST)
Date:   Thu, 5 Sep 2019 13:22:46 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next v2] netfilter: nf_tables: fix possible
 null-pointer dereference in object update
Message-ID: <20190905112246.tcqmpazua2n2dr5p@salvia>
References: <20190904122907.967-1-ffmancera@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904122907.967-1-ffmancera@riseup.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Sep 04, 2019 at 02:29:07PM +0200, Fernando Fernandez Mancera wrote:
> Not all objects need an update operation. If the object type doesn't implement
> an update operation and the user tries to update it there will be a EOPNOTSUPP
> error instead of a null pointer.

Applied, thanks.
