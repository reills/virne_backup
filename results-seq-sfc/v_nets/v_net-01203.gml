graph [
  node_attrs_setting [
    name "cpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "gpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "rom"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  link_attrs_setting "_networkx_list_start"
  link_attrs_setting [
    name "bw"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "link"
    type "resource"
  ]
  id 1203
  arrival_time 25112.59853216569
  lifetime 404.60289082130544
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 5
    gpu 43
    rom 49
  ]
  node [
    id 1
    label "1"
    cpu 19
    gpu 38
    rom 30
  ]
  node [
    id 2
    label "2"
    cpu 23
    gpu 34
    rom 48
  ]
  edge [
    source 0
    target 1
    bw 42
  ]
  edge [
    source 1
    target 2
    bw 24
  ]
]
