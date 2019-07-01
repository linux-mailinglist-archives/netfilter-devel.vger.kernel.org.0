Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFF7582B2
	for <lists+netfilter-devel@lfdr.de>; Thu, 27 Jun 2019 14:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfF0Mgm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 27 Jun 2019 08:36:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:2820 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbfF0Mgl (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 27 Jun 2019 08:36:41 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BC60F3092667;
        Thu, 27 Jun 2019 12:36:41 +0000 (UTC)
Received: from egarver.localdomain (ovpn-120-117.rdu2.redhat.com [10.10.120.117])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4078F1001B0E;
        Thu, 27 Jun 2019 12:36:41 +0000 (UTC)
Date:   Thu, 27 Jun 2019 08:36:35 -0400
From:   Eric Garver <eric@garver.life>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        shekhar sharma <shekhar250198@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] tests: py: use tempfile module
Message-ID: <20190627123635.6rvy2fyl3luk2pmu@egarver.localdomain>
Mail-Followup-To: Eric Garver <eric@garver.life>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        shekhar sharma <shekhar250198@gmail.com>,
        netfilter-devel@vger.kernel.org
References: <20190619133842.8602-1-eric@garver.life>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619133842.8602-1-eric@garver.life>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 27 Jun 2019 12:36:41 +0000 (UTC)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jun 19, 2019 at 09:38:42AM -0400, Eric Garver wrote:
> os.tmpfile() is not in python3.
> 
> Signed-off-by: Eric Garver <eric@garver.life>
> ---

Pablo,

Shekhar included this change in patch "[PATCH nft v9]tests: py: fix
pyhton3". So this patch can be dropped.

Thanks.
Eric.
