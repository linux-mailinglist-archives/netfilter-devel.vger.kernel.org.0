Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBBCFAF260
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Sep 2019 22:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbfIJUtW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 10 Sep 2019 16:49:22 -0400
Received: from correo.us.es ([193.147.175.20]:38258 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfIJUtW (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 10 Sep 2019 16:49:22 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id BFE231878AA
        for <netfilter-devel@vger.kernel.org>; Tue, 10 Sep 2019 22:49:18 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B02D1D1DBB
        for <netfilter-devel@vger.kernel.org>; Tue, 10 Sep 2019 22:49:18 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id A5535DA72F; Tue, 10 Sep 2019 22:49:18 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 97EAADA72F;
        Tue, 10 Sep 2019 22:49:16 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 10 Sep 2019 22:49:16 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [31.4.177.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 47E6842EF42A;
        Tue, 10 Sep 2019 22:49:16 +0200 (CEST)
Date:   Tue, 10 Sep 2019 22:49:14 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft v3] src: add synproxy stateful object support
Message-ID: <20190910204914.gimmpiuie74ouftg@salvia>
References: <20190908193720.26163-1-ffmancera@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190908193720.26163-1-ffmancera@riseup.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Sep 08, 2019 at 09:37:21PM +0200, Fernando Fernandez Mancera wrote:
> Add support for "synproxy" stateful object. For example (for TCP port 80 and
> using maps with saddr):
> 
> table ip foo {
> 	synproxy https-synproxy {
> 		mss 1460
> 		wscale 7
> 		timestamp sack-perm
> 	}
> 
> 	synproxy other-synproxy {
> 		mss 1460
> 		wscale 5
> 	}
> 
> 	chain bar {
> 		tcp dport 80 synproxy name "https-synproxy"
> 		synproxy name ip saddr map { 192.168.1.0/24 : "https-synproxy", 192.168.2.0/24 : "other-synproxy" }
> 	}
> }

Nice. Could you also add some tests for tests/py?

Thanks.
