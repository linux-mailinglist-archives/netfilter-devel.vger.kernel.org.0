Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2FC116C3FF
	for <lists+netfilter-devel@lfdr.de>; Tue, 25 Feb 2020 15:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbgBYOes (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 25 Feb 2020 09:34:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47081 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729189AbgBYOes (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 25 Feb 2020 09:34:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582641286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TjAqnk8OAMj2a3NgtvrNrm01gOFoConV01wzJH4zQE0=;
        b=bqoH+Fa5dDPmPjusJf/EbG4jaobnQuGdodmWOO9Z5vz5HMkRnqD6b2W6IfloQ4FZWm/DOR
        MPHynzpdzhGU0j/avH+6lz2rvDsdQMkzvzxsWAIn52qYs0cYTpJ0Ex2B80O5KvVOndsGmt
        ir4xQrvYRUmghcPNUyX3hY+lbs8YnNo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-YqYtArl-PWqqKJOl3x1Yhg-1; Tue, 25 Feb 2020 09:34:44 -0500
X-MC-Unique: YqYtArl-PWqqKJOl3x1Yhg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37CDF800D53;
        Tue, 25 Feb 2020 14:34:43 +0000 (UTC)
Received: from localhost (ovpn-200-22.brq.redhat.com [10.40.200.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E7A675C13D;
        Tue, 25 Feb 2020 14:34:40 +0000 (UTC)
Date:   Tue, 25 Feb 2020 15:34:35 +0100
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org,
        Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH nf 0/2] nft_set_pipapo: Fix crash due to dangling
 entries in mapping table
Message-ID: <20200225153435.17319874@redhat.com>
In-Reply-To: <20200225134236.sdz5ujufvxm2in3h@salvia>
References: <cover.1582250437.git.sbrivio@redhat.com>
        <20200221211704.GM20005@orbyte.nwl.cc>
        <20200221232218.2157d72b@elisabeth>
        <20200222011933.GO20005@orbyte.nwl.cc>
        <20200223222258.2bb7516a@redhat.com>
        <20200225123934.p3vru3tmbsjj2o7y@salvia>
        <20200225141346.7406e06b@redhat.com>
        <20200225134236.sdz5ujufvxm2in3h@salvia>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, 25 Feb 2020 14:42:36 +0100
Pablo Neira Ayuso <pablo@netfilter.org> wrote:

> On Tue, Feb 25, 2020 at 02:13:46PM +0100, Stefano Brivio wrote:
> > On Tue, 25 Feb 2020 13:39:34 +0100
> > Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> >   
> > > Hi,
> > > 
> > > On Sun, Feb 23, 2020 at 10:22:58PM +0100, Stefano Brivio wrote:  
> > > > Hi Phil,
> > > > 
> > > > On Sat, 22 Feb 2020 02:19:33 +0100
> > > > Phil Sutter <phil@nwl.cc> wrote:
> > > >     
> > > > > Hi Stefano,
> > > > > 
> > > > > On Fri, Feb 21, 2020 at 11:22:18PM +0100, Stefano Brivio wrote:    
> > > > > > On Fri, 21 Feb 2020 22:17:04 +0100
> > > > > > Phil Sutter <phil@nwl.cc> wrote:
> > > > > >       
> > > > > > > I found another problem, but it's maybe on user space side (and not a
> > > > > > > crash this time ;):
> > > > > > > 
> > > > > > > | # nft add table t
> > > > > > > | # nft add set t s '{ type inet_service . inet_service ; flags interval ; }
> > > > > > > | # nft add element t s '{ 20-30 . 40, 25-35 . 40 }'
> > > > > > > | # nft list ruleset
> > > > > > > | table ip t {
> > > > > > > | 	set s {
> > > > > > > | 		type inet_service . inet_service
> > > > > > > | 		flags interval
> > > > > > > | 		elements = { 20-30 . 40 }
> > > > > > > | 	}
> > > > > > > | }
> > > > > > > 
> > > > > > > As you see, the second element disappears. It happens only if ranges
> > > > > > > overlap and non-range parts are identical.
> > > > > > >
> > > > > > > Looking at do_add_setelems(), set_to_intervals() should not be called
> > > > > > > for concatenated ranges, although I *think* range merging happens only
> > > > > > > there. So user space should cover for that already?!      
> > > > > > 
> > > > > > Yes. I didn't consider the need for this kind of specification, given
> > > > > > that you can obtain the same result by simply adding two elements:
> > > > > > separate, partially overlapping elements can be inserted (which is, if I
> > > > > > recall correctly, not the case for rbtree).
> > > > > > 
> > > > > > If I recall correctly, we had a short discussion with Florian about
> > > > > > this, but I don't remember the conclusion.
> > > > > > 
> > > > > > However, I see the ugliness, and how this breaks probably legitimate
> > > > > > expectations. I guess we could call set_to_intervals() in this case,
> > > > > > that function might need some minor adjustments.
> > > > > > 
> > > > > > An alternative, and I'm not sure which one is the most desirable, would
> > > > > > be to refuse that kind of insertion.      
> > > > > 
> > > > > I don't think having concatenated ranges not merge even if possible is a
> > > > > problem. It's just a "nice feature" with some controversial aspects.
> > > > > 
> > > > > The bug I'm reporting is that Above 'add element' command passes two
> > > > > elements to nftables but only the first one makes it into the set. If
> > > > > overlapping elements are fine in pipapo, they should both be there. If
> > > > > not (or otherwise unwanted), we better error out instead of silently
> > > > > dropping the second one.    
> > > > 
> > > > Indeed, I agree there's a blatant bug, I was just wondering how to
> > > > solve it.    
> > > 
> > > With hashtable and bitmap, adding an element that already exists is
> > > fine:
> > > 
> > > nft add element x y { 1.1.1.1 }
> > > nft add element x y { 22 }
> > > nft add element x z { 1.1.1.1-2.2.2.2 }
> > > nft add element x k { 1.1.1.1-2.2.2.2 . 3.3.3.3 }
> > > 
> > > then, through 'create':
> > > 
> > > nft create element x y { 1.1.1.1 }
> > > nft create element x y { 22 }
> > > nft create element x z { 1.1.1.1-2.2.2.2 }
> > > nft create element x k { 1.1.1.1-2.2.2.2 . 3.3.3.3 }
> > > 
> > > these hit EEXIST, all good.
> > > 
> > > In pipapo, the following is silently ignored:
> > > 
> > > nft add element x k { 1.1.1.1-2.2.2.3 . 3.3.3.3 }
> > >                                     ^
> > > (just added a slightly large range). I tried _without_ these patches.  
> > 
> > I suppose you're doing something like:
> > 
> > nft add table x
> > nft add set x k '{ type ipv4_addr . ipv4_addr ; flags interval ; }'
> > nft add element x k { 1.1.1.1-2.2.2.2 . 3.3.3.3 }
> > nft add element x k { 1.1.1.1-2.2.2.3 . 3.3.3.3 }
> > 
> > in which case, yes, this is exactly the problem reported by Phil and my
> > point below: nft_pipapo_insert() reports -EEXIST on the second element,
> > but it's cleared by nft_add_set_elem().
> >   
> > > In rbtree, if you try to add an interval that already exists:
> > > 
> > > # nft add element x z { 1.1.0.0-1.1.2.254 }
> > > Error: interval overlaps with an existing one
> > > add element x z { 1.1.0.0-1.1.2.254 }
> > >                   ^^^^^^^^^^^^^^^^^
> > > Error: Could not process rule: File exists
> > > add element x z { 1.1.0.0-1.1.2.254 }
> > > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > 
> > > This complains as an overlap.  
> > 
> > It doesn't for me:  
> 
> I'm assuming there's already:
> 
> nft create element x z { 1.1.1.1-2.2.2.2 }
> 
> to trigger the EEXIST, see below.
> 
> > # nft add table x
> > # nft add set x z '{ type ipv4_addr ; flags interval ; }'
> > # nft add element x z { 1.1.0.0-1.1.2.254 }
> > # nft add element x z { 1.1.0.0-1.1.2.254 }
> > # echo $?
> > 0
> > 
> > that is, -EEXIST from nft_rbtree_insert() is also cleared by
> > nft_add_set_elem(). Am I trying it in a different way?  
> 
> No, this is the same behaviour I see here:
> 
> # nft add element x z { 1.1.0.0-1.1.2.254 }
> # nft add element x z { 1.1.0.0-1.1.2.254 }
> # echo $?
> 0
> 
> This is fine. If you use 'create' instead, the second command gets
> EEXIST.
> 
> But:
> 
> # nft add element x z { 1.1.0.0-1.1.2.254 }
> # nft add element x z { 1.1.0.0-1.1.2.1 }
> 
> Then, the second command hits EEXIST because of the overlap.

Okay, thanks, I see now. But this is not returned by the kernel: set
back-ends have no way to return -EEXIST on 'add' to userspace. This is
returned by set_overlap() in src/segtree.c, the element is not even
sent to the kernel.

> > > I think it's better to not extend userspace to dump the element cache
> > > for add/create, this slows down things for incremental updates
> > > (there's a ticket on bugzilla regarding this problem on the rbtree
> > > IIRC). Better if pipapo can handle this from the kernel.  
> > 
> > It does, the overlapping (entire or partial) is detected and
> > nft_pipapo_insert() reports -EEXIST.  
> 
> OK.
> 
> > > There is a automerge feature in the rbtree userspace that has been
> > > controversial. This was initially turned on by default, users were
> > > reporting that this was confusing. We can probably introduce a kernel
> > > flag to turn on this automerge feature so pipapo knows user is asking
> > > to not bail out with EEXIST, instead just merge? Not sure how hard is
> > > to implement merging.  
> > 
> > It's doable, the problem is that with multiple ranges as different
> > fields of single elements it might be ambiguous for which fields
> > merging should be attempted.
> > 
> > That is, in the '{ 20-30 . 40-50, 25-35 . 45-50 }' case below, should I
> > attempt merging 0, 1 or 2 fields? I think the 'automerge' feature would
> > be even more confusing here, assuming it can be defined at all.  
> 
> I'm not very fond of the automerge feature either. Some people have
> been asking for this though. I still don't understand the usecase.

I would then avoid touching that unless somebody comes up with a use
case, which in this case it will also need to suggest a specification
of how to handle this for concatenated fields.

> > > > I found out from notes with an old discussion with Florian what the
> > > > problem really was: for concatenated ranges, we might have stuff like:
> > > > 
> > > > 	'{ 20-30 . 40-50, 25-35 . 45-50 }'    
> > > 
> > > I think the second element should hit EEXIST.  
> > 
> > Yes, I also think so, and nft_pipapo_insert() reports that.
> >   
> > > > And the only sane way to handle this is as two separate elements. Also
> > > > note that I gave a rather confusing description of the behaviour with
> > > > "partially overlapping elements": what can partially overlap are ranges
> > > > within one field, but there can't be an overlap (even partial) over the
> > > > whole concatenation, because that creates ambiguity. That is,
> > > > 
> > > > 	'{ 20-30 . 40, 25-35 . 40 }'
> > > > 
> > > > the "second element" here is not allowed, while:
> > > > 
> > > > 	'{ 20-30 . 40, 25-35 . 41 }'
> > > > 
> > > > these elements both are.
> > > > 
> > > > Now, this turns into a question for Pablo. I started digging a bit
> > > > further, and I think that both userspace and nft_pipapo_insert()
> > > > observe a reasonable behaviour here: nft passes those as two elements,
> > > > nft_pipapo_insert() rejects the second one with -EEXIST.
> > > > 
> > > > However, in nft_add_set_elem(), we hit this:
> > > > 
> > > > 	err = set->ops->insert(ctx->net, set, &elem, &ext2);
> > > > 	if (err) {
> > > > 		if (err == -EEXIST) {
> > > > 			if (nft_set_ext_exists(ext, NFT_SET_EXT_DATA) ^
> > > > 			    nft_set_ext_exists(ext2, NFT_SET_EXT_DATA) ||
> > > > 			    nft_set_ext_exists(ext, NFT_SET_EXT_OBJREF) ^
> > > > 			    nft_set_ext_exists(ext2, NFT_SET_EXT_OBJREF)) {
> > > > 				err = -EBUSY;
> > > > 				goto err_element_clash;
> > > > 			}
> > > > 			if ((nft_set_ext_exists(ext, NFT_SET_EXT_DATA) &&
> > > > 			     nft_set_ext_exists(ext2, NFT_SET_EXT_DATA) &&
> > > > 			     memcmp(nft_set_ext_data(ext),
> > > > 				    nft_set_ext_data(ext2), set->dlen) != 0) ||
> > > > 			    (nft_set_ext_exists(ext, NFT_SET_EXT_OBJREF) &&
> > > > 			     nft_set_ext_exists(ext2, NFT_SET_EXT_OBJREF) &&
> > > > 			     *nft_set_ext_obj(ext) != *nft_set_ext_obj(ext2)))
> > > > 				err = -EBUSY;
> > > > 			else if (!(nlmsg_flags & NLM_F_EXCL))
> > > > 				err = 0;
> > > > 		}
> > > > 		goto err_element_clash;
> > > > 	}
> > > > 
> > > > and, in particular, as there's no "data" or "objref" extension
> > > > associated with the elements, we hit the:
> > > > 
> > > > 	if (!(nlmsg_flags & NLM_F_EXCL))
> > > > 
> > > > clause, introduced by commit c016c7e45ddf ("netfilter: nf_tables: honor
> > > > NLM_F_EXCL flag in set element insertion"). The error is reset, and we
> > > > return success, but the set back-end indicated a problem.
> > > > 
> > > > Now, if NLM_F_EXCL is not passed and the entry the user wants to add is
> > > > already present, even though I'd give RFC 3549 a different
> > > > interpretation (we won't replace the entry, but we should still report
> > > > the error IMHO), I see why we might return success in this case.
> > > >
> > > > The additional problem with concatenated ranges here is that the entry
> > > > might be conflicting (overlapping over the whole concatenation), but
> > > > not be the same as the user wants to insert. I think -EEXIST is the
> > > > code that still fits best in this case, so... do you see a better
> > > > alternative than changing nft_pipapo_insert() to return, say, -EINVAL?    
> > > 
> > > Please, no -EINVAL, it's very overloaded and I think we should only
> > > use this for missing netlink attributes / malformed netlink message.
> > > 
> > > If I understood your reasoning, I agree -EEXIST for an overlapping
> > > element is fine, even if NLM_F_EXCL is not set.  
> > 
> > So you're suggesting that I change nft_add_set_elem() like this:
> > 
> > @@ -5075,8 +5075,6 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
> >                              nft_set_ext_exists(ext2, NFT_SET_EXT_OBJREF) &&
> >                              *nft_set_ext_obj(ext) != *nft_set_ext_obj(ext2)))
> >                                 err = -EBUSY;
> > -                       else if (!(nlmsg_flags & NLM_F_EXCL))
> > -                               err = 0;  
> 
> IIRC, this is disabling the 'nft create element' behaviour. NLM_F_EXCL
> is not set for 'nft add element commands'.

Right, and if it's not set, set back-ends can't return -EEXIST to
userspace.

> Are you observing any inconsistency? I still don't see where the
> problem is.

This is the problem Phil reported:

> > > > > > On Fri, 21 Feb 2020 22:17:04 +0100
> > > > > > Phil Sutter <phil@nwl.cc> wrote:
> > > > > >       
> > > > > > > I found another problem, but it's maybe on user space side (and not a
> > > > > > > crash this time ;):
> > > > > > > 
> > > > > > > | # nft add table t
> > > > > > > | # nft add set t s '{ type inet_service . inet_service ; flags interval ; }
> > > > > > > | # nft add element t s '{ 20-30 . 40, 25-35 . 40 }'
> > > > > > > | # nft list ruleset
> > > > > > > | table ip t {
> > > > > > > | 	set s {
> > > > > > > | 		type inet_service . inet_service
> > > > > > > | 		flags interval
> > > > > > > | 		elements = { 20-30 . 40 }
> > > > > > > | 	}
> > > > > > > | }
> > > > > > > 
> > > > > > > As you see, the second element disappears. It happens only if ranges
> > > > > > > overlap and non-range parts are identical.

Or also simply with:

# nft add element t s '{ 20-30 . 40 }'
# nft add element t s '{ 25-35 . 40 }'

the second element is silently ignored. I'm returning -EEXIST from
nft_pipapo_insert(), but nft_add_set_elem() clears it because NLM_F_EXCL
is not set.

Are you suggesting that this is consistent and therefore not a problem?

Or are you proposing that I should handle this in userspace as it's done
for non-concatenated ranges?

-- 
Stefano

