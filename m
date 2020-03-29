Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92026196E12
	for <lists+netfilter-devel@lfdr.de>; Sun, 29 Mar 2020 17:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgC2PIf (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 29 Mar 2020 11:08:35 -0400
Received: from correo.us.es ([193.147.175.20]:58108 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728087AbgC2PIe (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 29 Mar 2020 11:08:34 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id C5B59D2DA14
        for <netfilter-devel@vger.kernel.org>; Sun, 29 Mar 2020 17:08:32 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B8EE0FF6F8
        for <netfilter-devel@vger.kernel.org>; Sun, 29 Mar 2020 17:08:32 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id AEB79FF6F2; Sun, 29 Mar 2020 17:08:32 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E6432FC553;
        Sun, 29 Mar 2020 17:08:30 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sun, 29 Mar 2020 17:08:30 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id C9A2442EF42A;
        Sun, 29 Mar 2020 17:08:30 +0200 (CEST)
Date:   Sun, 29 Mar 2020 17:08:30 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Romain Bellan <romain.bellan@wifirst.fr>
Cc:     netfilter-devel@vger.kernel.org,
        Florent Fourcot <florent.fourcot@wifirst.fr>
Subject: Re: [PATCH nf-next v4 2/2] netfilter: ctnetlink: be more strict when
 NF_CONNTRACK_MARK is not set
Message-ID: <20200329150830.ndwdjwryay6ans3e@salvia>
References: <20200327082632.27129-1-romain.bellan@wifirst.fr>
 <20200327082632.27129-2-romain.bellan@wifirst.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327082632.27129-2-romain.bellan@wifirst.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Mar 27, 2020 at 09:26:32AM +0100, Romain Bellan wrote:
> When CONFIG_NF_CONNTRACK_MARK is not set, any CTA_MARK or CTA_MARK_MASK
> in netlink message are not supported. We should return an error when one
> of them is set, not both

Also applied, thanks.
