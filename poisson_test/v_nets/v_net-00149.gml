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
  id 149
  arrival_time 2649.080123349353
  lifetime 1649.8804611211876
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 26
    gpu 8
    rom 21
  ]
  node [
    id 1
    label "1"
    cpu 38
    gpu 9
    rom 1
  ]
  node [
    id 2
    label "2"
    cpu 40
    gpu 49
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 23
    gpu 7
    rom 2
  ]
  node [
    id 4
    label "4"
    cpu 42
    gpu 33
    rom 25
  ]
  node [
    id 5
    label "5"
    cpu 49
    gpu 42
    rom 49
  ]
  edge [
    source 0
    target 1
    bw 32
  ]
  edge [
    source 1
    target 2
    bw 17
  ]
  edge [
    source 2
    target 3
    bw 15
  ]
  edge [
    source 3
    target 4
    bw 9
  ]
  edge [
    source 4
    target 5
    bw 50
  ]
]
