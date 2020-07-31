Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBEF4234C07
	for <lists+netfilter-devel@lfdr.de>; Fri, 31 Jul 2020 22:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgGaUOh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 31 Jul 2020 16:14:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59932 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726588AbgGaUOh (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 31 Jul 2020 16:14:37 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-u604JKJ5P5CptWWOE8mvcw-1; Fri, 31 Jul 2020 16:14:31 -0400
X-MC-Unique: u604JKJ5P5CptWWOE8mvcw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BCB08015F3;
        Fri, 31 Jul 2020 20:14:30 +0000 (UTC)
Received: from localhost (ovpn-115-201.rdu2.redhat.com [10.10.115.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E6507C0ED;
        Fri, 31 Jul 2020 20:14:27 +0000 (UTC)
Date:   Fri, 31 Jul 2020 16:14:26 -0400
From:   Eric Garver <eric@garver.life>
To:     Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>,
        "Jose M. Guisado Gomez" <guigom@riseup.net>,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft v2 1/1] src: enable output with "nft --echo --json"
 and nftables syntax
Message-ID: <20200731201426.qzmtdh5mdaoyqk53@egarver>
Mail-Followup-To: Eric Garver <eric@garver.life>,
        Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>,
        "Jose M. Guisado Gomez" <guigom@riseup.net>,
        netfilter-devel@vger.kernel.org
References: <20200730195337.3627-1-guigom@riseup.net>
 <20200731000020.4230-2-guigom@riseup.net>
 <20200731092212.GA1850@salvia>
 <20200731123342.GF13697@orbyte.nwl.cc>
 <20200731125825.GA12545@salvia>
 <20200731134828.GG13697@orbyte.nwl.cc>
 <20200731141742.so3oklljvtuad2cl@egarver>
 <20200731171906.GA15741@salvia>
 <20200731183633.eyobtrbgrmsgv7b7@egarver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731183633.eyobtrbgrmsgv7b7@egarver>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Jul 31, 2020 at 02:36:33PM -0400, Eric Garver wrote:
> On Fri, Jul 31, 2020 at 07:19:06PM +0200, Pablo Neira Ayuso wrote:
> > On Fri, Jul 31, 2020 at 10:17:42AM -0400, Eric Garver wrote:
> > > On Fri, Jul 31, 2020 at 03:48:28PM +0200, Phil Sutter wrote:
> > > > On Fri, Jul 31, 2020 at 02:58:25PM +0200, Pablo Neira Ayuso wrote:
> > > > > On Fri, Jul 31, 2020 at 02:33:42PM +0200, Phil Sutter wrote:
> > [...]
> > > > I'm assuming scripts will work directly with the Python data structures
> > > > that are later passed to libnftables as JSON. If they want to change a
> > > > rule, e.g. add a statement, it is no use if other statements disappear
> > > > or new ones are added by the commit->retrieve action.
> > > > 
> > > > Maybe Eric can shed some light on how Firewalld uses echo mode and
> > > > whether my concerns are relevant or not.
> > > 
> > > How it stands today is exactly as you described above. firewalld relies
> > > on the output (--echo) being in the same order as the input. At the
> > > time, and I think still today, this was the _only_ way to reliably get
> > > the rule handles. It's mostly due to the fact that input != output.
> > > 
> > > In the past we discussed allowing a user defined cookie/handle. This
> > > would allow applications to perform in a write only manner. They would
> > > not need to parse back the JSON since they already know the
> > > cookie/handle. IMO, this would be ideal for firewalld's use case.
> > 
> > The question is: Is this patch breaking anything in firewalld?
> 
> I tried v2 and v3. Neither break firewalld.

I rescind this statement - user error on my part. Both versions break
firewalld.

It looks like the reply is in a different order than the input. So
firewalld doesn't know where to find the rule handles. I'm trying to
come up with a minimal reproducer.

