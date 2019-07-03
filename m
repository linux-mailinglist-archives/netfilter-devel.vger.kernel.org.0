Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02DC25D6CD
	for <lists+netfilter-devel@lfdr.de>; Tue,  2 Jul 2019 21:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfGBTVt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 2 Jul 2019 15:21:49 -0400
Received: from ja.ssi.bg ([178.16.129.10]:58180 "EHLO ja.ssi.bg"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726291AbfGBTVs (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 2 Jul 2019 15:21:48 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.15.2/8.15.2) with ESMTP id x62JL17Y004951;
        Tue, 2 Jul 2019 22:21:01 +0300
Date:   Tue, 2 Jul 2019 22:21:01 +0300 (EEST)
From:   Julian Anastasov <ja@ssi.bg>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
cc:     Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        lvs-users@linuxvirtualserver.org, netfilter-devel@vger.kernel.org,
        Vadim Fedorenko <vfedorenko@yandex-team.ru>,
        Jacky Hu <hengqing.hu@gmail.com>
Subject: Re: [PATCH] ipvsadm: allow tunneling with gre encapsulation
In-Reply-To: <20190702134442.2c646c76@carbon>
Message-ID: <alpine.LFD.2.21.1907022210200.4236@ja.home.ssi.bg>
References: <20190701192537.4991-1-ja@ssi.bg> <20190702134442.2c646c76@carbon>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


	Hello,

On Tue, 2 Jul 2019, Jesper Dangaard Brouer wrote:

> On Mon,  1 Jul 2019 22:25:37 +0300
> Julian Anastasov <ja@ssi.bg> wrote:
> 
> > Add support for real server tunnels with GRE encapsulation:
> > --tun-type gre [--tun-nocsum|--tun-csum]
> > 
> > Co-developed-by: Vadim Fedorenko <vfedorenko@yandex-team.ru>
> > Signed-off-by: Vadim Fedorenko <vfedorenko@yandex-team.ru>
> > Signed-off-by: Julian Anastasov <ja@ssi.bg>
> > ---
> >  ipvsadm.8       | 19 ++++++++++++++-----
> >  ipvsadm.c       | 20 +++++++++++++++++++-
> >  libipvs/ip_vs.h |  1 +
> >  3 files changed, 34 insertions(+), 6 deletions(-)
> > 
> > 	Jesper, this will follow the other patchset from 30-MAY-2019,
> > "Allow tunneling with gue encapsulation".
> 
> I've applied Jacky's patches, which this patch builds on top of, to the
> ipvsadm kernel.org git tree[1].
> 
> Simon already signed off on your kernel side patch, but it's not
> applied to a kernel git tree yet... Do you want me to apply this, or
> wait for this to hit a kernel tree?

	The both GRE patches are already part of nf-next, so
it is fine to apply this ipvsadm patch for GRE now. It would be
better in case one wants to test the new features...

Regards

--
Julian Anastasov <ja@ssi.bg>
