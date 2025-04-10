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
  id 1960
  arrival_time 42915.11940869981
  lifetime 998.6997932260862
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 33
    gpu 13
    rom 20
  ]
  node [
    id 1
    label "1"
    cpu 4
    gpu 10
    rom 14
  ]
  node [
    id 2
    label "2"
    cpu 41
    gpu 19
    rom 49
  ]
  node [
    id 3
    label "3"
    cpu 33
    gpu 8
    rom 33
  ]
  edge [
    source 0
    target 1
    bw 29
  ]
  edge [
    source 1
    target 2
    bw 1
  ]
  edge [
    source 2
    target 3
    bw 10
  ]
]
