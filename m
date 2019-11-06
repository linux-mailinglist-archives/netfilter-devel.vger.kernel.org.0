Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9971F18C5
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 Nov 2019 15:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfKFOhi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 6 Nov 2019 09:37:38 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:42890 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727031AbfKFOhi (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 6 Nov 2019 09:37:38 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1iSMRD-000856-0G; Wed, 06 Nov 2019 15:37:35 +0100
Date:   Wed, 6 Nov 2019 15:37:34 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH] src: add `set_is_meter` helper.
Message-ID: <20191106143734.GO876@breakpoint.cc>
References: <20191105213154.23929-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105213154.23929-1-jeremy@azazel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Jeremy Sowden <jeremy@azazel.net> wrote:
> The sets constructed for meters are flagged as anonymous and dynamic.
> However, in some places there are only checks that they are dynamic,
> which can lead to normal sets being classified as meters.

Applied, thanks for including a test case.
