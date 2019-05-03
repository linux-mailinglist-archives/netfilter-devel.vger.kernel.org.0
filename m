Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8F5D13160
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 May 2019 17:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfECPnZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 3 May 2019 11:43:25 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:48482 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727460AbfECPnZ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 3 May 2019 11:43:25 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1hMaLM-0000wu-EA; Fri, 03 May 2019 17:43:24 +0200
Date:   Fri, 3 May 2019 17:43:24 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Eric Garver <eric@garver.life>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] parser_json: fix crash on add rule to bad references
Message-ID: <20190503154324.GL31599@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>, Eric Garver <eric@garver.life>,
        netfilter-devel@vger.kernel.org
References: <20190501163445.29604-1-eric@garver.life>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501163445.29604-1-eric@garver.life>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, May 01, 2019 at 12:34:45PM -0400, Eric Garver wrote:
> Pass the location via the handle so the error leg in
> rule_translate_index() can reference it. Applies to invalid references
> to tables, chains, and indexes.
> 
> Fixes: 586ad210368b ("libnftables: Implement JSON parser")
> Signed-off-by: Eric Garver <eric@garver.life>

Acked-by: Phil Sutter <phil@nwl.cc>
