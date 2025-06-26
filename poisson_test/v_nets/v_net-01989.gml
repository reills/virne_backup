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
  id 1989
  arrival_time 43405.599846249635
  lifetime 656.3647455306736
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 28
    gpu 34
    rom 41
  ]
  node [
    id 1
    label "1"
    cpu 44
    gpu 3
    rom 24
  ]
  node [
    id 2
    label "2"
    cpu 4
    gpu 49
    rom 39
  ]
  edge [
    source 0
    target 1
    bw 27
  ]
  edge [
    source 1
    target 2
    bw 0
  ]
]
