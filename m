Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F14FAE9B9F
	for <lists+netfilter-devel@lfdr.de>; Wed, 30 Oct 2019 13:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfJ3MiM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 30 Oct 2019 08:38:12 -0400
Received: from correo.us.es ([193.147.175.20]:40996 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbfJ3MiL (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 30 Oct 2019 08:38:11 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 68BA711ADC2
        for <netfilter-devel@vger.kernel.org>; Wed, 30 Oct 2019 13:38:04 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 575998294B
        for <netfilter-devel@vger.kernel.org>; Wed, 30 Oct 2019 13:38:04 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 4D267D1929; Wed, 30 Oct 2019 13:38:04 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 51CD9DA72F;
        Wed, 30 Oct 2019 13:38:02 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 30 Oct 2019 13:38:02 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (barqueta.lsi.us.es [150.214.188.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 4545442EE38F;
        Wed, 30 Oct 2019 13:38:02 +0100 (CET)
Date:   Wed, 30 Oct 2019 13:38:04 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Arturo Borrero Gonzalez <arturo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [conntrack-tools PATCH] docs: refresh references to
 /proc/net/core/rmem_default
Message-ID: <20191030123804.b3xcaliwooicrgbh@salvia>
References: <157243474476.18436.2577872078650825326.stgit@endurance>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <157243474476.18436.2577872078650825326.stgit@endurance>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Oct 30, 2019 at 12:25:44PM +0100, Arturo Borrero Gonzalez wrote:
> In recent kernel versions, /proc/net/core/rmem_default is now
> /proc/sys/net/core/rmem_default instead.
> 
> Refresh docs that mention this file.
> 
> Reported-by: Raphaël Bazaud <rbazaud@gmail.com>
> Signed-off-by: Arturo Borrero Gonzalez <arturo@netfilter.org>

Applied, thanks.
