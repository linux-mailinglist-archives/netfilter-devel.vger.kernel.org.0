Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A45A14B26
	for <lists+netfilter-devel@lfdr.de>; Mon,  6 May 2019 15:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfEFNrY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 6 May 2019 09:47:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52406 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfEFNrX (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 6 May 2019 09:47:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 10DBF87622;
        Mon,  6 May 2019 13:47:23 +0000 (UTC)
Received: from egarver.localdomain (ovpn-121-204.rdu2.redhat.com [10.10.121.204])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F268B60857;
        Mon,  6 May 2019 13:47:21 +0000 (UTC)
Date:   Mon, 6 May 2019 09:47:15 -0400
From:   Eric Garver <eric@garver.life>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, Phil Sutter <phil@nwl.cc>
Subject: Re: [PATCH nft] evaluate: force full cache update on rule index
 translation
Message-ID: <20190506134715.crrvun6iepgfr3p6@egarver.localdomain>
Mail-Followup-To: Eric Garver <eric@garver.life>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, Phil Sutter <phil@nwl.cc>
References: <20190501163510.29723-1-eric@garver.life>
 <20190505221847.72wvcyijkvrvxp6a@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190505221847.72wvcyijkvrvxp6a@salvia>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 06 May 2019 13:47:23 +0000 (UTC)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, May 06, 2019 at 12:18:47AM +0200, Pablo Neira Ayuso wrote:
> On Wed, May 01, 2019 at 12:35:10PM -0400, Eric Garver wrote:
> > If we've done a partial fetch of the cache and the genid is the same the
> > cache update will be skipped without fetching the rules. This causes the
> > index to handle lookup to fail. To remedy the situation we flush the
> > cache and force a full update.
> 
> @Eric: Would you mind to post a reproducer? I'd like to make a test
> for tests/shell/ infrastructure to make sure future changes don't
> break this.

I'll post a v2 with test additions.
