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
  id 1279
  arrival_time 26759.098020885933
  lifetime 458.8252925076644
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 14
    gpu 9
    rom 39
  ]
  node [
    id 1
    label "1"
    cpu 31
    gpu 13
    rom 3
  ]
  node [
    id 2
    label "2"
    cpu 31
    gpu 38
    rom 31
  ]
  node [
    id 3
    label "3"
    cpu 20
    gpu 33
    rom 6
  ]
  node [
    id 4
    label "4"
    cpu 14
    gpu 15
    rom 19
  ]
  edge [
    source 0
    target 1
    bw 49
  ]
  edge [
    source 1
    target 2
    bw 32
  ]
  edge [
    source 2
    target 3
    bw 40
  ]
  edge [
    source 3
    target 4
    bw 31
  ]
]
