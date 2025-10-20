
# VectorShop Demo

VectorShop 是一个基于 Ruby on Rails 与 PostgreSQL（pgvector）的演示项目，用于展示如何在电商场景中使用向量嵌入（embedding）进行语义推荐。

## 功能简介

- 产品（Product）、顾客（Customer）、订单（Order）三大核心模型  
- 场景标签（ScenarioTag）用于描述语义场景  
- pgvector 存储向量数据，用于计算语义相似度  
- 自动生成 embedding，用于推荐相似产品  
- 首页演示：展示产品及其相似商品推荐

## 技术栈

- Ruby 3.3.5  
- Rails 8.1+  
- PostgreSQL + pgvector  
- Docker + Docker Compose  
- SolidCache

## 本地运行

```bash
# 克隆项目
git clone https://github.com/yourname/vector-shop.git
cd vector-shop

# 构建镜像并启动服务
docker-compose build
docker-compose up

# 初始化数据库与种子数据
docker-compose run --rm web ./bin/rails db:prepare
docker-compose run --rm web ./bin/rails db:seed
```

.env.dev
```dotenv
GEMINI_API_KEY = YOUR_API_KEY
```

## 初始化向量

```ruby
# 在Rails Console内运行
# docker-compose run -rm web ./bin/rails c

# 保存一次LLM Model信息
RubyLLM.models.load_from_json!
Model.save_to_database

Product.each { |p| CreateProductScenarioService.call(p) }
Product.each { |p| CalculateScenarioRelatedEmbeddingService.call(p) }
Customer.each { |p| CreateCustomerScenarioService.call(p) }
Customer.each { |p| CalculateScenarioRelatedEmbeddingService.call(p) }
```

