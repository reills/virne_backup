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
  id 1543
  arrival_time 34148.968319425876
  lifetime 1157.2644519856824
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 6
    gpu 14
    rom 33
  ]
  node [
    id 1
    label "1"
    cpu 37
    gpu 9
    rom 8
  ]
  node [
    id 2
    label "2"
    cpu 33
    gpu 34
    rom 34
  ]
  edge [
    source 0
    target 1
    bw 29
  ]
  edge [
    source 1
    target 2
    bw 25
  ]
]
