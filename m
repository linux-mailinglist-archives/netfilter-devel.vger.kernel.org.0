Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C00A61A3D5
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 May 2019 22:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfEJUP0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 10 May 2019 16:15:26 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:38568 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727670AbfEJUPZ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 10 May 2019 16:15:25 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1hPBvP-0007qz-Se; Fri, 10 May 2019 22:15:23 +0200
Date:   Fri, 10 May 2019 22:15:23 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Eric Garver <eric@garver.life>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft v2] py: fix missing decode/encode of strings
Message-ID: <20190510201523.GC22379@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>, Eric Garver <eric@garver.life>,
        netfilter-devel@vger.kernel.org
References: <20190510122947.29854-1-eric@garver.life>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510122947.29854-1-eric@garver.life>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, May 10, 2019 at 08:29:47AM -0400, Eric Garver wrote:
> When calling ffi functions, if the string is unicode we need to convert
> to utf-8. Then convert back for any output we receive.
> 
> Fixes: 586ad210368b7 ("libnftables: Implement JSON parser")
> Signed-off-by: Eric Garver <eric@garver.life>

Acked-by: Phil Sutter <phil@nwl.cc>

Thanks, Phil
