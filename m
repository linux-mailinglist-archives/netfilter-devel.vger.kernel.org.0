Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DCF4F9A9D
	for <lists+netfilter-devel@lfdr.de>; Fri,  8 Apr 2022 18:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiDHQcS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 8 Apr 2022 12:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiDHQcR (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 8 Apr 2022 12:32:17 -0400
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [IPv6:2001:1600:4:17::42aa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B002E3104
        for <netfilter-devel@vger.kernel.org>; Fri,  8 Apr 2022 09:30:12 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KZkHl0GsDzMqWGw;
        Fri,  8 Apr 2022 18:30:11 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4KZkHk3gZLzljsTK;
        Fri,  8 Apr 2022 18:30:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1649435411;
        bh=4+d6wy3w5I981/VEAFSmrTx2Nn0Mu4dG8fguORjmyZg=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=CujV0ay6+bjIq7uMCpT058XsvsBVyjDaPeNBNMFgA45szhAK3vBDZiPeugbjNt/R3
         z5tGUUrbL71FT9sovbOKvJCz+fRvi1XukBUvkh2+zttrU7JwUagMIbA+r+HRqKChBT
         EgYlTOl+9cg1ICNv5BkciRgYSXt1TlD6GPqsPSIE=
Message-ID: <06f9ca1f-6e92-9d71-4097-e43b2f77b937@digikod.net>
Date:   Fri, 8 Apr 2022 18:30:09 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc:     willemdebruijn.kernel@gmail.com,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, yusongping@huawei.com,
        artem.kuzin@huawei.com, anton.sirazetdinov@huawei.com
References: <20220309134459.6448-1-konstantin.meskhidze@huawei.com>
 <20220309134459.6448-9-konstantin.meskhidze@huawei.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [RFC PATCH v4 08/15] landlock: add support network rules
In-Reply-To: <20220309134459.6448-9-konstantin.meskhidze@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On 09/03/2022 14:44, Konstantin Meskhidze wrote:
> This modification adds network rules support
> in internal landlock functions (presented in ruleset.c)
> and landlock_create_ruleset syscall.
> 
> Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> ---
> 
> Changes since v3:
> * Split commit.
> * Add network rule support for internal landlock functions.
> * Add set_masks and get_masks for network.
> * Add rb_root root_net_port.
> 
> ---
>   security/landlock/fs.c       |  2 +-
>   security/landlock/limits.h   |  6 +++
>   security/landlock/ruleset.c  | 88 +++++++++++++++++++++++++++++++++---
>   security/landlock/ruleset.h  | 14 +++++-
>   security/landlock/syscalls.c | 10 +++-
>   5 files changed, 109 insertions(+), 11 deletions(-)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 75ebdce5cd16..5cd339061cdb 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -231,7 +231,7 @@ static int check_access_path(const struct landlock_ruleset *const domain,
> 
>   			inode = d_backing_inode(walker_path.dentry);
>   			object_ptr = landlock_inode(inode)->object;
> -			layer_mask = landlock_unmask_layers(domain, object_ptr,
> +			layer_mask = landlock_unmask_layers(domain, object_ptr, 0,
>   							access_request, layer_mask,
>   							LANDLOCK_RULE_PATH_BENEATH);
>   			if (layer_mask == 0) {
> diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> index 2a0a1095ee27..fdbef85e4de0 100644
> --- a/security/landlock/limits.h
> +++ b/security/landlock/limits.h
> @@ -18,4 +18,10 @@
>   #define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_MAKE_SYM
>   #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
> 
> +#define LANDLOCK_LAST_ACCESS_NET	LANDLOCK_ACCESS_NET_CONNECT_TCP
> +#define LANDLOCK_MASK_ACCESS_NET	((LANDLOCK_LAST_ACCESS_NET << 1) - 1)
> +#define LANDLOCK_MASK_SHIFT_NET		16
> +
> +#define LANDLOCK_RULE_TYPE_NUM		LANDLOCK_RULE_NET_SERVICE
> +
>   #endif /* _SECURITY_LANDLOCK_LIMITS_H */
> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> index 7179b10f3538..1cecca59a942 100644
> --- a/security/landlock/ruleset.c
> +++ b/security/landlock/ruleset.c
> @@ -35,6 +35,7 @@ static struct landlock_ruleset *create_ruleset(const u32 num_layers)
>   	refcount_set(&new_ruleset->usage, 1);
>   	mutex_init(&new_ruleset->lock);
>   	new_ruleset->root_inode = RB_ROOT;
> +	new_ruleset->root_net_port = RB_ROOT;
>   	new_ruleset->num_layers = num_layers;
>   	/*
>   	 * hierarchy = NULL
> @@ -58,16 +59,32 @@ u32 landlock_get_fs_access_mask(const struct landlock_ruleset *ruleset, u16 mask
>   	return ruleset->access_masks[mask_level];
>   }
> 
> +/* A helper function to set a network mask */
> +void landlock_set_net_access_mask(struct landlock_ruleset *ruleset,
> +				  const struct landlock_access_mask *access_mask_set,
> +				  u16 mask_level)
> +{
> +	ruleset->access_masks[mask_level] |= (access_mask_set->net << LANDLOCK_MASK_SHIFT_NET);
> +}
> +
> +/* A helper function to get a network mask */
> +u32 landlock_get_net_access_mask(const struct landlock_ruleset *ruleset, u16 mask_level)
> +{
> +	return (ruleset->access_masks[mask_level] >> LANDLOCK_MASK_SHIFT_NET);
> +}

Both these helpers should be "static inline" and moved in net.h


> +
>   struct landlock_ruleset *landlock_create_ruleset(const struct landlock_access_mask *access_mask_set)
>   {
>   	struct landlock_ruleset *new_ruleset;
> 
>   	/* Informs about useless ruleset. */
> -	if (!access_mask_set->fs)
> +	if (!access_mask_set->fs && !access_mask_set->net)
>   		return ERR_PTR(-ENOMSG);
>   	new_ruleset = create_ruleset(1);
> -	if (!IS_ERR(new_ruleset))

This is better:

if (IS_ERR(new_ruleset))
	return new_ruleset;
if (access_mask_set->fs)
...


> +	if (!IS_ERR(new_ruleset) && access_mask_set->fs)
>   		landlock_set_fs_access_mask(new_ruleset, access_mask_set, 0);
> +	if (!IS_ERR(new_ruleset) && access_mask_set->net)
> +		landlock_set_net_access_mask(new_ruleset, access_mask_set, 0);
>   	return new_ruleset;
>   }
> 
> @@ -111,6 +128,9 @@ static struct landlock_rule *create_rule(
>   		landlock_get_object(object_ptr);
>   		new_rule->object.ptr = object_ptr;
>   		break;
> +	case LANDLOCK_RULE_NET_SERVICE:
> +		new_rule->object.data = object_data;
> +		break;
>   	default:
>   		return ERR_PTR(-EINVAL);
>   	}
> @@ -145,10 +165,12 @@ static void build_check_ruleset(void)
>   		.num_layers = ~0,
>   	};
>   	typeof(ruleset.access_masks[0]) fs_access_mask = ~0;
> +	typeof(ruleset.access_masks[0]) net_access_mask = ~0;
> 
>   	BUILD_BUG_ON(ruleset.num_rules < LANDLOCK_MAX_NUM_RULES);
>   	BUILD_BUG_ON(ruleset.num_layers < LANDLOCK_MAX_NUM_LAYERS);
>   	BUILD_BUG_ON(fs_access_mask < LANDLOCK_MASK_ACCESS_FS);
> +	BUILD_BUG_ON(net_access_mask < LANDLOCK_MASK_ACCESS_NET);
>   }
> 
>   /**
> @@ -191,6 +213,12 @@ static int insert_rule(struct landlock_ruleset *const ruleset,

Already reviewed.

[...]


> @@ -319,6 +363,9 @@ static int tree_merge(struct landlock_ruleset *const src,
>   	case LANDLOCK_RULE_PATH_BENEATH:
>   		src_root = &src->root_inode;
>   		break;
> +	case LANDLOCK_RULE_NET_SERVICE:
> +		src_root = &src->root_net_port;
> +		break;
>   	default:
>   		return -EINVAL;
>   	}
> @@ -338,11 +385,14 @@ static int tree_merge(struct landlock_ruleset *const src,
>   			return err;
>   		}
>   		layers[0].access = walker_rule->layers[0].access;
> -

nit: Please keep this empty line.


>   		switch (rule_type) {
>   		case LANDLOCK_RULE_PATH_BENEATH:
>   			err = insert_rule(dst, walker_rule->object.ptr, 0, &layers,
> -				ARRAY_SIZE(layers), rule_type);
> +					ARRAY_SIZE(layers), rule_type);

Please don't insert this kind of formatting in unrelated patches.


> +			break;
> +		case LANDLOCK_RULE_NET_SERVICE:
> +			err = insert_rule(dst, NULL, walker_rule->object.data, &layers,
> +					ARRAY_SIZE(layers), rule_type);
>   			break;
>   		}
>   		if (err)
> @@ -379,6 +429,10 @@ static int merge_ruleset(struct landlock_ruleset *const dst,
>   	err = tree_merge(src, dst, LANDLOCK_RULE_PATH_BENEATH);
>   	if (err)
>   		goto out_unlock;
> +	/* Merges the @src network tree. */
> +	err = tree_merge(src, dst, LANDLOCK_RULE_NET_SERVICE);
> +	if (err)
> +		goto out_unlock;
> 
>   out_unlock:
>   	mutex_unlock(&src->lock);
> @@ -398,6 +452,9 @@ static int tree_copy(struct landlock_ruleset *const parent,
>   	case LANDLOCK_RULE_PATH_BENEATH:
>   		parent_root = &parent->root_inode;
>   		break;
> +	case LANDLOCK_RULE_NET_SERVICE:
> +		parent_root = &parent->root_net_port;
> +		break;
>   	default:
>   		return -EINVAL;
>   	}
> @@ -410,6 +467,11 @@ static int tree_copy(struct landlock_ruleset *const parent,
>   				  &walker_rule->layers, walker_rule->num_layers,
>   				  rule_type);
>   			break;
> +		case LANDLOCK_RULE_NET_SERVICE:
> +			err = insert_rule(child, NULL, walker_rule->object.data,
> +				  &walker_rule->layers, walker_rule->num_layers,
> +				  rule_type);
> +			break;
>   		}
>   		if (err)
>   			return err;
> @@ -432,6 +494,10 @@ static int inherit_ruleset(struct landlock_ruleset *const parent,
> 
>   	/* Copies the @parent inode tree. */
>   	err = tree_copy(parent, child, LANDLOCK_RULE_PATH_BENEATH);
> +	if (err)
> +		goto out_unlock;
> +	/* Copies the @parent inode tree. */
> +	err = tree_copy(parent, child, LANDLOCK_RULE_NET_SERVICE);
>   	if (err)
>   		goto out_unlock;
> 
> @@ -464,6 +530,9 @@ static void free_ruleset(struct landlock_ruleset *const ruleset)
>   	rbtree_postorder_for_each_entry_safe(freeme, next, &ruleset->root_inode,
>   			node)
>   		free_rule(freeme, LANDLOCK_RULE_PATH_BENEATH);
> +	rbtree_postorder_for_each_entry_safe(freeme, next, &ruleset->root_net_port,
> +			node)
> +		free_rule(freeme, LANDLOCK_RULE_NET_SERVICE);
>   	put_hierarchy(ruleset->hierarchy);
>   	kfree(ruleset);
>   }
> @@ -565,6 +634,9 @@ const struct landlock_rule *landlock_find_rule(
>   	case LANDLOCK_RULE_PATH_BENEATH:
>   		node = ruleset->root_inode.rb_node;
>   		break;
> +	case LANDLOCK_RULE_NET_SERVICE:
> +		node = ruleset->root_net_port.rb_node;
> +		break;
>   	default:
>   		return ERR_PTR(-EINVAL);
>   	}
> @@ -586,8 +658,8 @@ const struct landlock_rule *landlock_find_rule(
>   /* Access-control management */
>   u64 landlock_unmask_layers(const struct landlock_ruleset *const domain,
>   			   const struct landlock_object *object_ptr,
> -			   const u32 access_request, u64 layer_mask,
> -			   const u16 rule_type)
> +			   const u16 port, const u32 access_request,
> +			   u64 layer_mask, const u16 rule_type)
>   {
>   	const struct landlock_rule *rule;
>   	size_t i;
> @@ -600,6 +672,10 @@ u64 landlock_unmask_layers(const struct landlock_ruleset *const domain,
>   			LANDLOCK_RULE_PATH_BENEATH);
>   		rcu_read_unlock();
>   		break;
> +	case LANDLOCK_RULE_NET_SERVICE:
> +		rule = landlock_find_rule(domain, (uintptr_t)port,

Type casting should not be required.

[...]
